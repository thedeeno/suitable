require 'bundler'
Bundler.setup(:default, :test)

require 'dotenv'
# load repo level then library level environment files
Dotenv.load "../.env.test", ".env.test"

# Twilio's test numbers documented here:
# https://www.twilio.com/docs/api/rest/test-credentials
MAGIC_NUMBERS = {
  valid: "+15005550006",
  invalid: "+15005550001",
  unrouteable: "+15005550002",
}

require 'support/output_capture'
RSpec.configure do |config|
end

