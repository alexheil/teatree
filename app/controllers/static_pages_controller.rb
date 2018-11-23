class StaticPagesController < ApplicationController

  def home
    if user_signed_in?
      @subscriptions = current_user.feed
      @subscribing = current_user.subscribing
    end
    @users = User.all
    @videos = Video.popular
  end

  def privacy
  end

  def terms
  end

  def about
  end

  def faq
  end

  def updates
  end

  def guidelines
  end

  def become_member
    if user_signed_in?
      @user = current_user
      Stripe.api_key = Rails.configuration.stripe[:secret_key]
      @customer = Stripe::Customer.retrieve(@user.customer_id)
      if @user.membership.blank?
        @membership = Membership.new
      end
      if @user.merchant.present?
        @merchant = Stripe::Account.retrieve(@user.merchant.stripe_id)
      end
    end
  end
  
end