require 'bundler'
Bundler.setup(:default, :test)


require 'dotenv'
Dotenv.load ".env.test"


require 'suitor'


# Twilio's test numbers documented here:
# https://www.twilio.com/docs/api/rest/test-credentials
MAGIC_NUMBERS = {
  valid: "+15005550006",
  invalid: "+15005550001",
  unrouteable: "+15005550002",
}


require 'rspec'
require 'support/output_capture'
RSpec.configure do |config|
end

