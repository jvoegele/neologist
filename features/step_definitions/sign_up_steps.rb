Given(/^I am on the sign up page$/) do
  visit(signup_path)
end

Given(/^I am not logged in$/) do
  # For now, just assume this
end

When(/^I sign up with valid information$/) do
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

Then(/^I should be logged in$/) do
  step 'I should be logged in as "jvoegele"'
end

