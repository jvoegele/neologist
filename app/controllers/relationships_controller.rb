class RelationshipsController < ApplicationController
  before_filter :authorize

  def create
    @user = User.find(params[:relationship][:followed_id])
    current_user.follow!(@user)
    flash[:notice] = "Following #{@user.username}"
    redirect_to @user
  end

  def destroy
    # Find the relationship in the current_user's relationships, lest we allow
    # arbitrary relationships to be destroyed by arbitrary requests.
    relationship = current_user.relationships.find_by_id(params[:id])
    if relationship
      @user = relationship.followed
      current_user.unfollow!(@user)
      flash[:notice] = "Unfollowed #{@user.username}"
    end
    redirect_to @user
  end
end
