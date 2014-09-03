require 'open3'

When(/^I run suitor with "(.*)"$/) do |argument_string|
  Dir.chdir("../cli") do
    # clean bundler's environment so we can safley nest the bundle exec call
    Bundler.with_clean_env do
      @output, @status = Open3.capture2e("bundle exec ./bin/suitor #{argument_string}")
    end
  end
end

Then(/^the output includes "(.*)"$/) do |text|
  expect(@output).to include(text)
end

Then(/^the process exits (\d+)$/) do |code|
  expect(@status.exitstatus.to_s).to eq(code)
end
