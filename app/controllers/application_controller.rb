class ApplicationController < ActionController::Base
  protect_from_forgery

protected

  def current_user_id
    @current_user_id ||= session[:user_id]
  end

  def current_user_id=(user_id)
    @current_user_id = user_id
    session[:user_id] = user_id
  end

  def current_user
    @current_user ||= User.find(current_user_id) if current_user_id
  end
  helper_method :current_user

  def authorize
    redirect_to login_url, alert: "Not authorized" if current_user.nil?
  end
end
