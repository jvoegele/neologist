class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(params[:user])
    if @user.save
      self.current_user_id = @user.id
      redirect_to root_url, notice: "Signed up as #{@user.username}"
    else
      render new
    end
  end
end
