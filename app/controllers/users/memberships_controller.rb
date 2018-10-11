class Users::MembershipsController < ApplicationController

  before_action :authenticate_user!
  before_action :correct_user
  before_action :set_user
  before_action :yes_member, only: [:new, :create]
  before_action :no_member, only: [:edit, :update]

  def new
    @membership = Membership.new
  end

  def create
   
    Stripe.api_key = "sk_test_ECd3gjeIEDsGkySmF8FQOC5i"

    # find customer
    customer = Stripe::Customer.retrieve(@user.customer_id)
    
    # check if customer has a source on file
    if customer.default_source.blank?
      url = "#{request.protocol}#{request.host_with_port}#{request.fullpath}/edit"
      redirect_to edit_user_source_path(@user, :url => Base64.encode64(url))
    else
      # create a Stripe membership
      subscription = Stripe::Subscription.create({
        customer: customer.id,
        items: [{
          plan: params[:membership][:membership_type] + "_id"
        }],
      })

      subscription.save

      if subscription.save
        @membership = @user.create_membership(
          stripe_subscription_id: subscription.id,
          membership_type: params[:membership][:membership_type]
        )
        send_email
        redirect_to user_path(@user)
      end
    end

  end

  def edit
    @membership = @user.membership
  end

  def update
    @membership = @user.membership

    # update current_id to match plan id
    @membership.update_attributes(
      current_id: params[:membership][:membership_type] + "_id"
    )
   
    Stripe.api_key = "sk_test_ECd3gjeIEDsGkySmF8FQOC5i"

    # find customer
    customer = Stripe::Customer.retrieve(@user.customer_id)
    
    # check if customer has a source on file
    if customer.default_source.blank?
      url = "#{request.protocol}#{request.host_with_port}#{request.fullpath}/edit"
      redirect_to edit_user_source_path(@user, :url => Base64.encode64(url))
    else
      # grab Stripe membership and update it
      subscription = Stripe::Subscription.retrieve(@membership.stripe_subscription_id)
      subscription.items = [{
        id: subscription.items.data[0].id,
        plan: @membership.current_id
      }]

      subscription.save

      if subscription.save
        @membership.update_attributes(
          stripe_subscription_id: subscription.id,
          membership_type: params[:membership][:membership_type]
        )
        redirect_to user_path(@user)
      end
    end

  end

  def destroy
    @membership = @user.membership

    Stripe.api_key = "sk_test_ECd3gjeIEDsGkySmF8FQOC5i"

    subscription = Stripe::Subscription.retrieve(@membership.stripe_subscription_id)

    if subscription.delete
      @membership.destroy
      redirect_to new_user_membership_path(@user)
      flash[:notice] = "zYour membership has been deleted."
    else
      redirect_to new_user_membership_path(@user)
      flash[:alert] = ""
    end
  end

  private

    def set_user
      @user = current_user
    end

    def is_member
      @user = current_user
      if @user.membership.nil?
        redirect_to new_user_membership_path(@user)
      else
        redirect_to edit_user_membership_path(@user, @user.membership)
      end
    end

    def yes_member
      @user = current_user
      if @user.membership
        redirect_to edit_user_membership_path(@user, @user.membership)
      end
    end

    def no_member
      @user = current_user
      if @user.membership.nil?
        redirect_to new_user_membership_path(@user)
      end
    end

    def correct_user
      @user = User.friendly.find(params[:user_id])
      if current_user != @user
        redirect_to user_path(@user)
        flash[:alert] = "This is not your profile."
      end
    end

    def send_email
      UserMailer.membership_email(@user, @membership).deliver_now
    end

    def membership_params
      params.require(:membership).permit(:stripe_subscription_id, :current_id, :membership_type)
    end

end
