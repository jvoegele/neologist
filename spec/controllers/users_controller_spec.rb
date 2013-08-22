require 'spec_helper'

describe UsersController do
  let(:user) { FactoryGirl.create(:user) }
  let(:current_user) { FactoryGirl.create(:user, username: 'current') }
  before do
    session[:user_id] = current_user.id
    @all_quips = create_quips(user, 9) do |quip, i|
      current_user.add_favorite!(quip) if i.even?
    end
    @favorites, @others = @all_quips.partition {|q| current_user.favorite?(q)}
    @favorites = @favorites.sort_by { |quip| quip.created_at }.reverse
  end

  describe "GET 'favorites'" do
    it "requires login" do
      session[:user_id] = nil
      get :favorites
      response.should redirect_to login_path
    end

    it "displays all favorites" do
      get :favorites
      assigns(:quips).should == @favorites
    end

    it "should not include any non-favorites" do
      get :favorites
      @others.each do |quip|
        assigns(:quips).should_not include(quip)
      end
    end
  end

  describe "POST 'add_favorite'" do
    it "requires login" do
      session[:user_id] = nil
      get :favorites
      response.should redirect_to login_path
    end

    it "adds a quip to the current user's favorites" do
      quip = @others.first
      post :add_favorite, quip_id: quip.id
      current_user.should be_favorite(quip)
    end
  end
end
