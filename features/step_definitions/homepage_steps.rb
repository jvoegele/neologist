When(/^I visit the homepage$/) do
  visit root_path
end

Then(/^I should be shown a login form$/) do
  current_path.should == login_path
end

Then(/^I should be shown my timeline$/) do
  current_path.should == timeline_path
end
