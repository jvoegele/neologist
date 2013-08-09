When(/^I post the quip "(.*?)"$/) do |quip_content|
  visit(quip_path)
  fill_in('quip_content', with: quip_content)
  click_button('Post Quip')
end

Then(/^I should see the quip "(.*?)" on my page$/) do |quip_content|
  page.should have_content(quip_content)
end

Then(/^I should see a message indicating that the quip is too long$/) do
  page.should have_content("Quip is too long")
end

