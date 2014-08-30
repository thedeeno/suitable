lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'suitor/version'

Gem::Specification.new do |spec|
  spec.name          = "suitor"
  spec.version       = Suitor::VERSION
  spec.authors       = ["Dane O'Connor"]
  spec.email         = ["dane.oconnor@gmail.com"]
  spec.summary       = %q{Woo your sweethearts with sms messages}
  spec.description   = %q{
This gem includes an html and cli interface. It uses content from reddit to
generate sms messages and dispatch them to a phone of your choosing.
  }.strip
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  # core dependencies
  spec.add_runtime_dependency "redditkit", "~> 1.0"
  spec.add_runtime_dependency "twilio-ruby", "~> 3.12"
  spec.add_runtime_dependency "dotenv", "~> 0.11"

  # cli dependencies
  spec.add_runtime_dependency "clamp", "~> 0.6"

  # app dependencies
  spec.add_runtime_dependency "sinatra", "~> 1.4"
  spec.add_runtime_dependency "sinatra-contrib", "~> 1.4"
  spec.add_runtime_dependency "haml", "~> 4"

  spec.add_development_dependency "bundler", "~> 1.6"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "foreman"

  # testing
  spec.add_development_dependency "rack-test"
  spec.add_development_dependency "capybara", "~> 2.4.1"
  spec.add_development_dependency "selenium-webdriver"
end
