class Users::PlansController < ApplicationController

  before_action :authenticate_user!
  before_action :merchant_account
  before_action :correct_user
  before_action :set_user

  def new
    if user_signed_in? && current_user.merchant.present?
      @plan = Plan.new

      Stripe.api_key = "sk_test_ECd3gjeIEDsGkySmF8FQOC5i"
    
    elsif user_signed_in? && current_user.merchant.nil?
      redirect_to new_user_merchant_path(current_user)
      flash[:alert] = "You need to set up a merchant account first."
    else
      redirect_to root_url
    end
  end

  def create
    Stripe.api_key = "sk_test_ECd3gjeIEDsGkySmF8FQOC5i"

    plan = Stripe::Plan.create({
      amount: (params[:plan][:amount].to_i * 100).to_s,
      interval: "month",
      product:
      {
        id: @user.username + "_" + @user.id.to_s,
        name: @user.username + "_" + @user.id.to_s,
        statement_descriptor: "BLOOTV | " + @user.username[0...13].upcase
      },
      currency: params[:plan][:currency],
      id: @user.username + "_" + @user.id.to_s
    }, stripe_account: @user.merchant.stripe_id)

    if plan.save
      @user.create_plan(
        plan_id: plan.id,
        product_id: plan.product,
        amount: plan.amount / 100,
        currency: plan.currency
      )
      redirect_to user_path(@user)
      flash[:notice] = "You have successfully created a subscription!"
    else
      redirect_to user_path(@user)
      flash[:alert] = "You failed to create a subscription."
    end
  end

  def edit
    if user_signed_in? && current_user.merchant.present?
      @plan = @user.plan

    elsif user_signed_in? && current_user.merchant.nil?
      redirect_to new_user_merchant_path(current_user)
      flash[:alert] = "You need to set up a merchant account first."
    else
      redirect_to root_url
    end
  end

  def update
    @plan = @user.plan

    Stripe.api_key = "sk_test_ECd3gjeIEDsGkySmF8FQOC5i"

    plan = Stripe::Plan.retrieve(@user.plan.plan_id, stripe_account: @user.merchant.stripe_id)
    plan.delete
    product = Stripe::Product.retrieve(@user.plan.product_id, stripe_account: @user.merchant.stripe_id)
    product.delete

    plan = Stripe::Plan.create({
      amount: (params[:plan][:amount].to_i * 100).to_s,
      interval: "month",
      product:
      {
        id: @user.username + "_" + @user.id.to_s,
        name: @user.username + "_" + @user.id.to_s,
        statement_descriptor: "BLOOTV | " + @user.username[0...13].upcase
      },
      currency: params[:plan][:currency],
      id: @user.username + "_" + @user.id.to_s
    }, stripe_account: @user.merchant.stripe_id)


    if plan.save
      @plan.update_attributes(
        plan_id: plan.id,
        product_id: plan.product,
        amount: plan.amount / 100,
        currency: plan.currency
      )
      redirect_to user_path(@user)
      flash[:notice] = "You have successfully created a subscription!"
    else
      redirect_to user_path(@user)
      flash[:alert] = "You failed to create a subscription."
    end
  end

  def destroy
    @plan = @user.plan

    Stripe.api_key = "sk_test_ECd3gjeIEDsGkySmF8FQOC5i"

    plan = Stripe::Plan.retrieve(@plan.plan_id, stripe_account: @user.merchant.stripe_id)
    product = Stripe::Product.retrieve(@plan.product_id, stripe_account: @user.merchant.stripe_id)
    if plan.delete && product.delete
      @plan.destroy
      redirect_to user_path(@user)
      flash[:notice] = "You have successfully deleted your subscription!"
    else
      redirect_to user_path(@user)
      flash[:alert] = "You were unable to delete your subscription!"
    end
  end

  private

    def set_user
      @user = current_user
    end

    def merchant_account
      @user = current_user
      if @user.merchant.nil?
        redirect_to new_user_merchant_path(@user)
        flash[:alert] = "You need to set up a merchant account first."
      end
    end

    def correct_user
      @user = User.friendly.find(params[:user_id])
      if current_user != @user
        redirect_to user_path(@user)
        flash[:alert] = "This is not you."
      end
    end

    def plan_params
      params.require(:plan).permit(:plan_id, :product_id, :amount, :currency)
    end


end