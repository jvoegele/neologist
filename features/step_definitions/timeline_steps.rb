Given(/^I am following some users$/) do
  11.times do |i|
    user = FactoryGirl.create(:user, username: "user#{i}")
    @current_user.follow!(user)
  end
end

Given(/^the users have posted some quips$/) do
  @current_user.followed_users.each do |user|
    9.times do |i|
      minutes = rand(24 * 60)
      FactoryGirl.create(:quip, content: minutes.to_s ,user: user, created_at: minutes.minutes.ago)
    end
  end
end

When(/^I view my timeline$/) do
  visit(timeline_path)
end

Then(/^I should see up to "(.*?)" quips from my followed users$/) do |count|
  count = Integer(count)
  quips = page.all('.user-quip')
  quips.should have_exactly(count).items
end

Then(/^the quips should be displayed in reverse chronological order$/) do
  quips = page.all('.user-quip').map {|quip_element| quip_element.text}
  quips.sort_by {|q| q.to_i}.should == quips
end
