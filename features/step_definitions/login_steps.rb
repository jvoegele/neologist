Given(/^that I am on the login page$/) do
  visit(login_path)
end

When(/^I login with valid credentials$/) do
  @current_user = FactoryGirl.create(:user, username: 'jvoegele', password: 'something', password_confirmation: 'something')
  fill_in 'username', with: 'jvoegele'
  fill_in 'password', with: 'something'
  click_button 'Log In'
end

When(/^I login with invalid credentials$/) do
  fill_in 'username', with: 'tux'
  fill_in 'password', with: 'penguin'
  click_button 'Log In'
end

Then(/^I should be returned to the login page$/) do
  current_path.should == login_path
end

Then(/^I should see an error message$/) do
  page.should have_content('Username or password is invalid')
end

Given(/^that I am logged in$/) do
  step "that I am on the login page"
  step "I login with valid credentials"
end

Given(/^that I am not logged in$/) do
  visit logout_path
end

