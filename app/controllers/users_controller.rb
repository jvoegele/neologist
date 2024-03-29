class UsersController < ApplicationController
  before_filter :authorize, except: [:show, :new, :create]
  layout 'basic_form', only: [:new]

  def index
    @users = User.where('1=1').paginate(page: params[:page])
    render 'show_follows'
  end

  def show
    @user = User.find(params[:id])
    if @user
      quips = @user.quips
      @quips = quips.paginate(page: params[:page]) if quips
    end
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(params[:user])
    if @user.save
      self.current_user_id = @user.id
      redirect_to timeline_path, notice: "Signed up as #{@user.username}"
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

  def favorites
    user = params[:id] ? User.find(params[:id]) : current_user
    @quips = user.favorite_quips.paginate(page: params[:page])
  end

  def add_favorite
    do_favorite(:add_favorite!)
  end

  def remove_favorite
    do_favorite(:remove_favorite!)
  end
private

  def show_follows(list)
    @user = User.find(params[:id])
    @users = @user.send(list).paginate(page: params[:page])
    render 'show_follows'
  end

  def do_favorite(action)
    quip = Quip.find_by_id(params[:quip_id])
    current_user.send(action, quip)
    respond_to do |format|
      format.html do
        redirect_to favorites_path
      end
      format.js do
        render(action.to_s.sub(/!$/, ''), locals: {quip: quip})
      end
    end
  end
end
