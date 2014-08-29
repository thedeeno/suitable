require 'rubygems'
require 'bundler'
Bundler.setup(:default, :test)


require 'dotenv'
Dotenv.load ".env.test"

require 'rspec'
RSpec.configure do |config|
end
