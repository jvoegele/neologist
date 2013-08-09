require 'spec_helper'

describe User do
  before do
    @user = User.new(username: 'jvoegele', password: 'something', password_confirmation: 'something')
    @user.save
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

  describe "#latest_quips" do
    before do
      42.times do |i|
        quip = Quip.new(content: "I am quip #{i}")
        quip.user_id = @user.id
        quip.save
      end
    end

    it "returns at most 20 quips by default" do
      @user.latest_quips.should have_exactly(20).items
    end

    it "takes an optional count parameter" do
      @user.latest_quips(count: 33).should have_exactly(33).items
    end

    it "returns the most recent quips" do
      all_quips = Set.new(@user.quips)
      latest_quips = Set.new(@user.latest_quips)
      older_quips = all_quips - latest_quips
      latest_quips.each do |quip|
        older_quips.all? { |old_quip| quip.created_at.should be > old_quip.created_at }
      end
    end

    it "returns quips in descending date order" do
      latest_quips = @user.latest_quips.to_a
      sorted_quips = latest_quips.sort_by {|quip| quip.created_at}.to_a.reverse
      latest_quips.should == sorted_quips
    end
  end
end
