class UserMailerPreview < ActionMailer::Preview
  # Accessible from http://localhost:3000/rails/mailers/email/welcome

  def subscribed_email
    UserMailer.subscribed_email(User.first)
  end

  def subscriber_email
    UserMailer.subscriber_email(User.first, User.last, Subscription.first)
  end

  def merchant_email
    UserMailer.merchant_email(User.first, Merchant.first)
  end

  def membership_email
    UserMailer.membership_email(User.first, Membership.first)
  end

end