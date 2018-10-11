class Users::MerchantsController < ApplicationController

  before_action :authenticate_user!
  before_action :correct_user
  before_action :set_user
  before_action :yes_merchant, only: [:new, :create]

  def new
    @merchant = Merchant.new
  end

  def create

    Stripe.api_key = "sk_test_ECd3gjeIEDsGkySmF8FQOC5i"

    @account = Stripe::Account.create(
      type: 'custom',
      country: (params[:merchant][:country])[0,2],
      email: @user.email,
      tos_acceptance: {
        ip: request.remote_ip,
        date: Time.now.to_i
      },
      legal_entity: {
        dob: {
          month: params[:merchant][:month],
          day: params[:merchant][:day],
          year: params[:merchant][:year]
        },
        first_name: params[:merchant][:first_name],
        last_name: params[:merchant][:last_name],
        type: 'individual'
      }
    )

    if @account.save
      @merchant = @user.create_merchant(
        first_name: @account.legal_entity.first_name,
        last_name: @account.legal_entity.last_name,
        month: @account.legal_entity.dob.month,
        day: @account.legal_entity.dob.day,
        year: @account.legal_entity.dob.year,
        currency: @account.default_currency,
        country: @account.country,
        stripe_id: @account.id
      )
      send_email
      redirect_to edit_user_merchant_path(@user, @merchant)
      flash[:notice] = "Before we can transfer your payments we need more information."
    else
      redirect_to user_path(@user)
      flash[:alert] = "Your merchant account failed to create."
    end

  end

  def edit
    @merchant = @user.merchant

    Stripe.api_key = "sk_test_ECd3gjeIEDsGkySmF8FQOC5i"

    @account = Stripe::Account.retrieve(@merchant.stripe_id)
  end

  def update
    @merchant = @user.merchant

    Stripe.api_key = "sk_test_ECd3gjeIEDsGkySmF8FQOC5i"

    account = Stripe::Account.retrieve(@merchant.stripe_id)

    if params[:merchant][:bank_account_number].present?
      account.external_accounts.create(
        external_account: {
          object: 'bank_account',
          account_number: params[:merchant][:bank_account_number],
          routing_number: params[:merchant][:bank_routing_number],
          country: account.country,
          currency: params[:merchant][:currency]
        }
      )
    end

    account.legal_entity.address.line1 = params[:merchant][:line1]
    account.legal_entity.address.city = params[:merchant][:city]
    account.legal_entity.address.postal_code = params[:merchant][:postal_code]
    account.legal_entity.personal_address.line1 = params[:merchant][:line1] unless account.country == 'US'
    account.legal_entity.personal_address.city = params[:merchant][:city] unless account.country == 'US'
    account.legal_entity.personal_address.postal_code = params[:merchant][:postal_code] unless account.country == 'US'
    account.legal_entity.address.state = params[:merchant][:state]
    account.legal_entity.ssn_last_4 = params[:merchant][:ssn_last_4] if params[:merchant][:ssn_last_4]
    account.legal_entity.personal_id_number = params[:merchant][:personal_id_number] if params[:merchant][:personal_id_number]
    account.default_currency = params[:merchant][:currency]

    account.save

    if account.save
      @merchant.update_attributes(
        first_name: params[:merchant][:first_name],
        last_name: params[:merchant][:last_name],
        month: params[:merchant][:month],
        day: params[:merchant][:day],
        year: params[:merchant][:year],
        currency: account.default_currency
      )
      if @merchant.save
        redirect_to user_path(@user)
        flash[:notice] = "You've updated your merchant account."
      else
        render 'edit'
      end
    else
      redirect_to user_path(@user)
      flash[:alert] = "Your merchant account failed to update."
    end

  end

  private

    def set_user
      @user = current_user
    end

    def correct_user
      @user = User.friendly.find(params[:user_id])
      if current_user != @user
        redirect_to user_path(@user)
        flash[:alert] = "This is not you."
      end
    end

    def yes_merchant
      @user = current_user
      if @user.merchant
        @merchant = @user.merchant
        redirect_to edit_user_merchants_path(@user, @merchant) if @merchant.country.present?
      end
    end

    def send_email
      UserMailer.merchant_email(@user, @merchant).deliver_now
    end

end
