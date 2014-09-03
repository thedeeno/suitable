require 'uri'

Given(/^I am a visitor$/) do
  @visitor = Suitor::Acceptance::VisitorAgent.new("visitor")
end

When(/^I visit suitor$/) do
  @visitor.visit(@app.home)
end

When(/^I enter a valid number$/) do
  @visitor.enter("phone_number", MAGIC_NUMBERS.valid)
end

When(/^I enter a unrouteable number$/) do
  @visitor.enter("phone_number", MAGIC_NUMBERS.unrouteable)
end

When(/^I enter an invalid number$/) do
  @visitor.enter("phone_number", "foo bar")
end

When(/^I enter a valid subreddit$/) do
  @visitor.enter("subreddit", "romance")
end

When(/^I enter a non-existant subreddit$/) do
  @visitor.enter("subreddit", "thisistotalandcompletegarbageanddoesnotexit")
end

# Capybara has a hard time clicking on submit input types.
# Just hard code the element for now
When(/^I click "Send Message"$/) do
  @visitor.session.find("form .button").click
end

Then(/^I should see "(.*?)"$/) do |text|
  @visitor.see!(text: text)
end

Then(/^I should see the sms body$/) do
  @visitor.see!(css: ".last-charm")
end
