Given(/^I have marked some quips as favorites$/) do
  user = FactoryGirl.create(:user)
  quips = create_quips(user, 5) do |quip, n|
    @current_user.add_favorite!(quip) if n.odd?
  end
  @favorite_quips = quips.find_all {|quip| @current_user.favorite?(quip)}
end

When(/^I visit my favorite quips page$/) do
  visit favorites_path
end

When(/^I mark one of the quips as a favorite$/) do
  button_id = "favorite_#{@some}"
  page.find("##{button_id}").click
end

When(/^I unfavorite one of my favorite quips$/) do
  step %{I visit my favorite quips page}
  @unfavorite = @favorite_quips.first
  page.click_button("unfavorite_#{@unfavorite.id}")
end

Then(/^I should see all of my favorite quips$/) do
  @favorite_quips.each do |quip|
    page.should have_content(quip.content)
  end
end

Then(/^I should see the quip in my list of favorites$/) do
  step %{I visit my favorite quips page}
  page.should have_content("User quip #{@some}")
end

Then(/^I should not see the quip in my list of favorites$/) do
  step %{I visit my favorite quips page}
  page.should_not have_content(@unfavorite.content)
end

