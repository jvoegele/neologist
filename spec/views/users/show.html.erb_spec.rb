require 'spec_helper'

describe "users/show.html.erb" do
  let(:user) { FactoryGirl.create(:user) }
  let(:current_user) { FactoryGirl.create(:user, username: 'arbitrary') }
  before do
    assign(:user, user)
    @quips = user.quips.paginate(page: 1)
    assign(:quips, @quips)
    view.stub(:current_user).and_return(current_user)
  end

  def render_with_layout
    render template: 'users/show', layout: 'layouts/application'
  end

  it "displays the username" do
    render_with_layout
    rendered.should have_text(user.username)
  end

  describe "quip count" do
    it "displays the number of quips" do
      user.should_receive(:quip_count).and_return(12358)
      render_with_layout
      rendered.should have_text('12358')
    end
  end

  describe "following stats" do
    before do
      user.should_receive(:following_count).and_return(42)
      render_with_layout
    end
    it "displays a link to list of followed users" do
      rendered.should have_link('following_stats')
    end

    it "displays count of following" do
      rendered.should have_text('42')
    end
  end
  describe "followers stats" do
    before do
      user.should_receive(:followers_count).and_return(1234)
      render_with_layout
    end
    it "displays a link to list of followers" do
      rendered.should have_link('followers_stats')
    end

    it "displays count of following" do
      rendered.should have_text('1234')
    end
  end

  describe "button to follow or unfollow or edit" do
    it "displays a Follow button for unfollowed users" do
      current_user.should_not be_following(user)
      render_with_layout
      rendered.should have_button('Follow')
    end

    it "displays an Unfollow button for followed users" do
      current_user.follow!(user)
      render_with_layout
      rendered.should have_button('Unfollow')
    end
  end
end
