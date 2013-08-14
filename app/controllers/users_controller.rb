class UsersController < ApplicationController
  layout 'basic_form', only: [:new]

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
      render :new
    end
  end

  def following
    show_follows(:followed_users)
  end

  def followers
    show_follows(:followers)
  end

  def timeline
    @quips = current_user.timeline.paginate(page: params[:page])
  end

private

  def show_follows(list)
    @user = User.find(params[:id])
    @users = @user.send(list).paginate(page: params[:page])
    render 'show_follows'
  end
end
