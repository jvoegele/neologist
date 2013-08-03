Then(/^I should see the following quips:$/) do |table|
  quips = extract_quips(table)
  quips.each do |quip_text|
    page.should have_content(quip_text)
  end
end
