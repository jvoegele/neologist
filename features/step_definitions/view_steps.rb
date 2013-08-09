Then(/^I should see the following quips:$/) do |table|
  quips = extract_quips(table)
  quips.each do |quip_text|
    page.should have_content(quip_text)
  end
end

Then(/^I should see the most recent "(.*?)" quips in reverse chronological order$/) do |count|
  count = Integer(count)
  quips = page.all('.user-quip').map {|quip_element| quip_element.text}
  quips.should have_exactly(count).items
  quips.sort.reverse.should == quips
end
