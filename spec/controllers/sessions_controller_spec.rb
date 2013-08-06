require 'spec_helper'

describe SessionsController do

  describe "GET 'new'" do
    it "returns http success" do
      get 'new'
      response.should be_success
    end
  end

  describe "POST create" do

    before(:each) do
      @user = mock_model(User)
    end

    it "stores :user_id in the session" do
      User.should_receive(:find_by_username).with('jvoegele').and_return(@user)
      @user.should_receive(:authenticate).with('something').and_return(true)
      post :create, :username => 'jvoegele', :password => 'something'
      session[:user_id].should == @user.id
      response.should redirect_to(root_url)
    end
  end

  describe "POST destroy" do
    it "removes :user_id from the session" do
      post :destroy
      session[:user_id].should be_nil
      response.should redirect_to(root_url)
    end
  end
end
