class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

    def configure_permitted_parameters
      added_attrs = [:username, :email, :password, :password_confirmation, :current_password, :remember_me, :customer_id, :purchase_email, :refund_email, :subscription_email, :suggestion_email, :comment_email, :message_email, :video_email, :post_email, :update_email]
      devise_parameter_sanitizer.permit :sign_up, keys: added_attrs
      devise_parameter_sanitizer.permit :account_update, keys: added_attrs
    end

end
