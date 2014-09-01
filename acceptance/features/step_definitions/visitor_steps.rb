require 'uri'

Given(/^the suitor app is available$/) do
  # TODO: remove hard coded address
  uri = URI.parse("http://localhost:9230")
  @app = Suitor::Acceptance::AppDescriptor.new(uri)
  expect(@app).to be_available, "Suitor app is not available at #{@app}\n"
end

Given(/^a visitor "(\w+)"$/) do |name|
  @visitor = Suitor::Acceptance::VisitorAgent.new(name)
end

When(/^(?:he|she) visits the suitor index$/) do
  @visitor.visit(@app.home)
end

When(/^(?:he|she) enters a valid phone number$/) do
  @visitor.enter("phone_number", "5556667777")
end

When(/^(?:he|she) enters a valid subreddit$/) do
  @visitor.enter("subreddit", "romance")
end

When(/^(?:he|she) submits the charm$/) do
  @visitor.click("Charm")
end

Then(/^(?:he|she) should see "(.*?)"$/) do |text|
  @visitor.see!(text: text)
end

Then(/^(?:he|she) should see the generated charm$/) do
  @visitor.see!(css: ".last-charm")
end
