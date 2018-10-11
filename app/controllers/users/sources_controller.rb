class Users::SourcesController < ApplicationController

  def edit
    if user_signed_in?
      @user = current_user

      Stripe.api_key = "sk_test_ECd3gjeIEDsGkySmF8FQOC5i"

      @customer = Stripe::Customer.retrieve(@user.customer_id)

      if @customer.default_source.present?
        @card = @customer.sources.retrieve(@customer.default_source)
      end
    else
      redirect_to root_url
    end
  end

  def update
    @user = current_user

    redirection = nil
    if params[:url].present?
      redirection = Base64.decode64(params[:url].to_s)
    end

    Stripe.api_key = "sk_test_ECd3gjeIEDsGkySmF8FQOC5i"

    customer = Stripe::Customer.retrieve(@user.customer_id)

    token = params[:stripeToken]

    source = customer.sources.create({source: token})
    customer.default_source = source.id
    customer.save

    card = customer.sources.retrieve(customer.default_source)
    card.name = params[:user][:cardholder]
    card.save

    if customer.save
      if redirection.present?
        path = redirection
      else
        path = user_path(@user)
      end
      redirect_to path
    end
  end

end