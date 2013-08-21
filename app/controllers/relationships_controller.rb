class RelationshipsController < ApplicationController
  before_filter :authorize

  def create
    @user = User.find(params[:relationship][:followed_id])
    current_user.follow!(@user)
    respond_to do |format|
      format.html do
        flash[:notice] = "Following #{@user.username}"
        redirect_to @user
      end
      format.js do
        render('create', locals: {user: @user})
      end
    end
  end

  def destroy
    # Find the relationship in the current_user's relationships, lest we allow
    # arbitrary relationships to be destroyed by arbitrary requests.
    relationship = current_user.relationships.find_by_id(params[:id])
    if relationship
      @user = relationship.followed
      current_user.unfollow!(@user)
    end
    respond_to do |format|
      format.html do
        flash[:notice] = "Unfollowed #{@user.username}"
        redirect_to @user
      end
      format.js do
        render('destroy', locals: {user: @user})
      end
    end
  end
end
