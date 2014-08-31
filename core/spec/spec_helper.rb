require 'bundler'
Bundler.setup(:default, :test)

require 'dotenv'
# load repo level then library level environment files
Dotenv.load "../.env.test", ".env.test"

require 'suitor'

ENV["TWILIO_SID"]="AC7e31bd1b30e2d4654b9daf6e3b6dc144"
ENV["TWILIO_TOKEN"]="113706c73513d870ed6718efdad08b9b"

ENV["FROM_PHONE"]="+15005550006"
ENV["TO_PHONE"]="2153006753"

ENV["REDDIT_KIT_USER"]="ruby_relay_bot"
ENV["REDDIT_KIT_PASS"]="PahkThaCah"

# Twilio's test numbers documented here:
# https://www.twilio.com/docs/api/rest/test-credentials
MAGIC_NUMBERS = {
  valid: "+15005550006",
  invalid: "+15005550001",
  unrouteable: "+15005550002",
}


require 'rspec'
RSpec.configure do |config|
end

