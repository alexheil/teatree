class UserMailer < ApplicationMailer
  default from: 'notifications@teatree.tv'

  def subscribed_email(user)
    @user = user
    mail(to: @user.email, subject: 'You have new subscribers on Tea Tree!')
  end

  def subscriber_email(subscriber, subscribed, subscription)
    @subscriber = subscriber
    @subscribed = subscribed
    @subscription = subscription
    mail(to: @subscriber.email, subject: 'You\'re a new subscriber on Tea Tree!')
  end

  def merchant_email(user, merchant)
    @user = user
    @merchant = merchant
    mail(to: @user.email, subject: 'You\'ve set up a merchant account on Tea Tree!')
  end

  def membership_email(user, membership)
    @user = user
    @membership = membership
    mail(to: @user.email, subject: 'You are now a member of Tea Tree')
  end

end