Given(/^there is a User$/) do
  FactoryGirl.create(:user, username: '___', password: '______', password_confirmation: '______')
end

Given(/^the User has posted the following quips:$/) do |table|
  User.count.should == 1
  quips = extract_quips(table)
  quips.each do |quip_text|
    FactoryGirl.create(:quip, :content => quip_text, :user => User.first)
  end
end

Given(/^the user has posted more than "(.*?)" quips$/) do |count|
  user = User.first
  count = Integer(count) * 2
  count.times do |i|
    FactoryGirl.create(:quip, content: "#{i}", user: user)
  end
end

When(/^I visit the User's page$/) do
  User.count.should == 1
  visit(user_path(User.first))
end

