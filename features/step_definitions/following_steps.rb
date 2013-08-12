When(/^I follow the User$/) do
  visit(user_path(@user))
  click_button 'Follow'
end

When(/^I am followed by the User$/) do
  @user.follow!(@current_user)
end

Then(/^I should see the User on my following list$/) do
  visit(following_user_path(@current_user))
  page.should have_content(@user.username)
end

Then(/^I should see the User on my followers list$/) do
  visit(followers_user_path(@current_user))
  page.should have_content(@user.username)
end


