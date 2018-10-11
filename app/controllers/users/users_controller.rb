class Users::UsersController < ApplicationController
  
  def show
    @user = User.friendly.find(params[:id])
    if user_signed_in?
      @subscription = Subscription.new
    end
  end

  def about
    @user = User.friendly.find(params[:user_id])
  end

  def subscriptions
    @user = User.friendly.find(params[:user_id])
    @subscriptions = @user.subscribing
  end
  
end