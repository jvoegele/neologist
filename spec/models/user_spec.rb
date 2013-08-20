require 'spec_helper'

describe User do
  before do
    @user = FactoryGirl.create(:user, full_name: 'Jason Voegele', username: 'jvoegele')
  end

  it "is valid with valid attributes" do
    @user.should be_valid
  end

  it "is not valid without a full name" do
    @user.full_name = nil
    @user.should_not be_valid
  end

  it "is not valid without an email address" do
    @user.email = nil
    @user.should_not be_valid
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

  describe "#quip_count" do
    it "returns the total number of quips" do
      9.times do @user.new_quip(content: 'hello').save end
      @user.quip_count.should == 9
    end
  end

  describe "#new_quip" do
    let(:quip) { @user.new_quip(content: 'Hello world!') }
    it "returns a new Quip with the given content" do
      quip.content.should == 'Hello world!'
    end

    it "is associated with the user" do
      quip.user.should == @user
    end

    it "is in the user's quips" do
      @user.quips.should include(quip)
    end

    it "is not yet saved" do
      quip.should be_new_record
    end
  end

  describe "#latest_quips" do
    before do
      42.times do |i|
        @user.new_quip(content: "I am quip #{i}").save
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

  context "relationships" do
    it { should respond_to(:followed_users) }
    it { should respond_to(:following?) }

    let(:other_user) { FactoryGirl.create(:user) }
    before do
      @user.follow!(other_user)
    end

    describe "#follow!" do
      it "should be following the other user" do
        @user.should be_following(other_user)
      end

      it "should include the other user in its list of followed" do
        @user.followed_users.should include(other_user)
      end

      describe "followed user" do
        subject { other_user }
        it "should be followed by the following user" do
          subject.followers.should include(@user)
        end
      end
    end

    describe "#unfollow!" do
      it "should not be following the other user any longer" do
        @user.unfollow!(other_user)
        @user.should_not be_following(other_user)
      end
    end

    describe "#following_count" do
      it "returns the number of followed users" do
        @user.following_count.should == 1
      end
    end
    describe "#followers_count" do
      it "returns the number of followers" do
        other_user.follow!(@user)
        @user.followers_count.should == 1
      end
    end
  end

  context "favorites" do
    it { should respond_to(:add_favorite!) }
    it { should respond_to(:remove_favorite!) }
    it { should respond_to(:favorite_quips) }
    it { should respond_to(:favorite?) }

    let(:quip) { FactoryGirl.create(:quip) }

    describe "#favorite_quips" do
      it "should initially be empty" do
        @user.favorite_quips.should be_empty
      end

      it "should not be favorited" do
        @user.should_not be_favorite(quip)
      end
    end

    describe "#add_favorite!" do
      it "should mark the quip as favorite" do
        @user.add_favorite!(quip)
        @user.should be_favorite(quip)
      end
      it "should add the quip to #favorite_quips" do
        @user.add_favorite!(quip)
        @user.favorite_quips.should include(quip)
      end

      it "should ignore quips that are already favorites" do
        @user.should_not be_favorite(quip)
        @user.add_favorite!(quip)
        @user.should be_favorite(quip)
        @user.add_favorite!(quip).should be_false
      end
    end

    describe "#remove_favorite!" do
      before do
        @user.add_favorite!(quip)
      end
      it "should ensure that the quip is not favorite" do
        @user.remove_favorite!(quip)
        @user.should_not be_favorite(quip)
      end
      it "should remove the quip from #favorite_quips" do
        @user.remove_favorite!(quip)
        @user.should_not be_favorite(quip)
      end
    end
  end
end
