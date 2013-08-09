require 'spec_helper'

describe QuipsController do

  describe "GET 'new'" do
    it "returns http success" do
      get 'new'
      response.should be_success
    end
  end

  describe "POST 'create'" do
    it "requires login" do
      post 'create'
      response.should redirect_to login_path
    end
  end
end
