class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_action :authenticate_user!, unless: :authenticate_user_from_token!
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
    if user = User.find_by_email(user_email.presence)
      if user && Devise.secure_compare(user.auth_token, user_token)
        sign_in user, store: false
        return true
      else
        return false
      end
    else
      return false
    end
  end

  def user_email
    params[:user_email] = request.headers["User-Email"] if request.headers["User-Email"]
    params[:user_email]
  end

  def user_token
    params[:user_token] = request.headers["User-Token"] if request.headers["User-Token"]
    params[:user_token]
  end

end
