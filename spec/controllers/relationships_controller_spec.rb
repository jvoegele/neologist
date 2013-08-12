require 'spec_helper'

describe RelationshipsController do
  let(:current_user) { FactoryGirl.create(:user, username: 'current') }
  let(:other_user) { FactoryGirl.create(:user, username: 'other') }

  describe "POST 'create'" do
    it "requires login" do
      post :create
      response.should redirect_to login_path
    end

    it "establishes following relationship" do
      session[:user_id] = current_user.id
      post :create, relationship: { followed_id: other_user.id }
      current_user.should be_following(other_user)
    end
  end

  describe "POST 'destroy'" do
    it "requires login" do
      post :destroy, id: 1
      response.should redirect_to login_path
    end

    it "breaks the following relationship" do
      session[:user_id] = current_user.id
      relationship = current_user.follow!(other_user)
      current_user.should be_following(other_user)
      post :destroy, id: relationship.id
      current_user.should_not be_following(other_user)
    end
  end
end
