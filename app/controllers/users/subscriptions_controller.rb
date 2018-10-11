class Users::SubscriptionsController < ApplicationController

  before_action :authenticate_user!
  before_action :check_default_source, only: :create

  def create
    @subscriber = current_user
    @subscribed = User.friendly.find(params[:subscribed_id])

    Stripe.api_key = "sk_test_ECd3gjeIEDsGkySmF8FQOC5i"
    customer = Stripe::Customer.retrieve(@subscriber.customer_id)

    token = Stripe::Token.create({
      customer: customer.id,
      card: customer.default_source,
    }, stripe_account: @subscribed.merchant.stripe_id)

    subscription_customer = Stripe::Customer.create({
      email: @subscriber.email
    }, stripe_account: @subscribed.merchant.stripe_id)

    plan = Stripe::Plan.retrieve(@subscribed.plan.plan_id, stripe_account: @subscribed.merchant.stripe_id)

    subscription = Stripe::Subscription.create({
      customer: subscription_customer.id,
      source: token,
      application_fee_percent: 15,
      items: [{
        plan: plan.id
      }],
    }, stripe_account: @subscribed.merchant.stripe_id)

    subscription.save

    if subscription.save
      @subscription = @subscriber.active_subscriptions.create(
        stripe_subscription_id: subscription.id,
        subscriber_id: @subscriber.id,
        subscribed_id: @subscribed.id,
        amount: @subscribed.plan.amount,
        currency: @subscribed.plan.currency
      )
      send_email
      redirect_to user_path(@subscribed)
      flash[:notice] = "You subscribed to #{@subscribed.profile.first_name.presence || @subscribed.username}!"
    else 
      redirect_to root_url
    end
  end

  def destroy
    @subscribed = Subscription.find(params[:id]).subscribed
    @subscription = Subscription.find(params[:id])

    Stripe.api_key = "sk_test_ECd3gjeIEDsGkySmF8FQOC5i"

    subscription = Stripe::Subscription.retrieve(@subscription.stripe_subscription_id, stripe_account: @subscribed.merchant.stripe_id)

    if subscription.delete
      current_user.unsubscribe(@subscribed)
      redirect_to user_path(@subscribed)
      flash[:notice] = "You unsubscribed from #{@subscribed.profile.first_name.presence || @subscribed.username}."
    else
      redirect_to user_path(@subscribed)
      flash[:alert] = "You did not unsubscribe from #{@subscribed.profile.first_name.presence || @subscribed.username}."
    end
  end

  private

    def check_default_source
      @subscribed = User.friendly.find(params[:subscribed_id])
      @subscriber = current_user
      Stripe.api_key = "sk_test_ECd3gjeIEDsGkySmF8FQOC5i"
      customer = Stripe::Customer.retrieve(@subscriber.customer_id)
      if customer.default_source.blank?
        url = user_url(@subscribed)
        redirect_to edit_user_source_path(@subscriber, :url => Base64.encode64(url))
      end
    end

    def send_email
      UserMailer.subscriber_email(@subscriber, @subscribed, @subscription).deliver_now
    end

end