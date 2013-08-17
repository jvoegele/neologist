Given(/^there is a User$/) do
  @user = FactoryGirl.create(:user, username: '___', password: '______', password_confirmation: '______')
end

Given(/^the User has posted the following quips:$/) do |table|
  quips = extract_quips(table)
  quips.each do |quip_text|
    FactoryGirl.create(:quip, :content => quip_text, :user => @user)
  end
end

Given(/^the user has posted more than "(.*?)" quips$/) do |count|
  user = @user
  count = Integer(count) * 2
  count.times do |i|
    FactoryGirl.create(:quip, content: "#{i}", user: user)
  end
end

Given(/^the User has posted some quips$/) do
  @some = 9
  (1..@some).each do |i|
    FactoryGirl.create(:quip, content: "User quip #{i}", user: @user)
  end
end

When(/^I visit the User's page$/) do
  visit(user_path(@user))
end

