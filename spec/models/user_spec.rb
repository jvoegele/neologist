require 'spec_helper'

describe User do
  before(:each) do
    @user = User.new(username: 'jvoegele', password: 'something', password_confirmation: 'something')
  end

  it "is valid with valid attributes" do
    @user.should be_valid
  end

  it "is not valid without a username" do
    @user.username = nil
    @user.should_not be_valid
  end

  context "username validations" do
    it "must be at least 3 characters" do
      @user.username = 'hi'
      @user.should_not be_valid
    end

    it "must be no more than 16 characters" do
      @user.username = '0123456789abcdef_'
      @user.should_not be_valid
    end

    it "can contain underscores" do
      @user.username = '1_000_000'
      @user.should be_valid
    end

    it "cannot contain spaces" do
      @user.username = 'hi there'
      @user.should_not be_valid
    end

    it "cannot contain dashes" do
      @user.username = 'jason-voegele'
      @user.should_not be_valid
    end

    it "cannot contain dots" do
      @user.username = 'jason.voegele'
      @user.should_not be_valid
    end

    context "password validations" do
      def new_user(password)
        User.new(username: '___', password: password, password_confirmation: password)
      end

      it "must be at least 6 characters" do
        new_user('2shrt').should_not be_valid
      end

      it "must be no more than 24 characters" do
        new_user('abcdefghijklmnopqrstuvwxyz').should_not be_valid
      end
    end
  end
end
