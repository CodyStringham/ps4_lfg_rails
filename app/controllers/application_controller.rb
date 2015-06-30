class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_filter :authenticate_user_from_token!
  before_action :set_session_for_mobile_app
  before_action :set_browser_type

  private

  def set_session_for_mobile_app
    session[:show_navigation] = 'false' if request.headers[:navigation] == 'false'
  end

  def set_browser_type
    request.variant = :phone if browser.mobile?
    request.variant = :tablet if browser.tablet?
  end

  def authenticate_user_from_token!
    user_email = params[:user_email].presence
    user       = user_email && User.find_by_email(user_email)
    if user && Devise.secure_compare(user.authentication_token, params[:user_token])
      sign_in user, store: false
    end
  end

end
