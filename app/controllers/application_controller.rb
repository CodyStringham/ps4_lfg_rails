class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

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

end
