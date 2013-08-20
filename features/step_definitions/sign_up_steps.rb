Given(/^I am on the sign up page$/) do
  visit(signup_path)
end

Given(/^I am not logged in$/) do
  # For now, just assume this
end

When(/^I sign up with valid information$/) do
  fill_in 'user_full_name', with: 'Jason Voegele'
  fill_in 'user_email', with: 'jason@jvoegele.com'
  fill_in 'user_username', with: 'jvoegele'
  fill_in 'user_password', with: 'something'
  fill_in 'user_password_confirmation', with: 'something'
  click_button 'Sign Up'
end

When(/^I sign up with a username that is already taken$/) do
  FactoryGirl.create(:user, username: 'jvoegele', password: 'something', password_confirmation: 'something')
  fill_in 'user_username', with: 'jvoegele'
  fill_in 'user_password', with: 'something'
  fill_in 'user_password_confirmation', with: 'something'
  click_button 'Sign Up'
end

Then(/^I should be registered$/) do
  User.first.username.should == 'jvoegele'
end

Then(/^I should see a confirmation message$/) do
  page.should have_content("Signed up as jvoegele")
end

Then(/^I should see a message indicating that the username is already in use$/) do
  page.should have_content("Username jvoegele has already been taken")
end

Then(/^I should be logged in$/) do
  step 'I should be logged in as "jvoegele"'
end

When(/^I sign up with invalid information$/) do
  fill_in 'user_username', with: 'i am not a valid username hahahaha!!!'
  fill_in 'user_password', with: 'something'
  fill_in 'user_password_confirmation', with: 'something'
  click_button 'Sign Up'
end

Then(/^I should see validation error messages$/) do
  page.find_by_id('validation_errors').should_not be_nil
  page.should have_content('Please correct the following errors')
end
