Then(/^I should be logged in as "(.*?)"$/) do |username|
  page.find_by_id('current_username').text.should == username
end
