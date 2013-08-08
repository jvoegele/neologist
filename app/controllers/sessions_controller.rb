class SessionsController < ApplicationController
  layout 'basic_form'

  def new
  end

  def create
    user = User.find_by_username(params[:username])
    if user && user.authenticate(params[:password])
      self.current_user_id = user.id
      redirect_to root_url, notice: "Logged in!"
    else
      flash.alert = "Username or password is invalid"
      redirect_to login_path
    end
  end

  def destroy
    self.current_user_id = nil
    redirect_to root_url, notice: "Logged out!"
  end
end
