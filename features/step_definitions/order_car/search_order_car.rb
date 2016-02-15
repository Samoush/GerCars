
Given(/^I am on the OrderCar Search page$/) do
  visit order_cars_search_by_chassi_path
end

Given(/^I fill in "([^"]*)" with "([^"]*)"$/) do |arg1, arg2|
  fill_in arg1, with: arg2
end

When(/^I press "([^"]*)"$/) do |arg1|
  click_button arg1
end

Then(/^page should have content "([^"]*)"$/) do |arg1|
  expect(page).to have_content(arg1)
end
