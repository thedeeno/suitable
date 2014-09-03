Gem::Specification.new do |spec|
  spec.name          = "suitor"
  spec.version       = "0.0.2"
  spec.authors       = ["Dane O'Connor"]
  spec.email         = ["dane.oconnor@gmail.com"]
  spec.summary       = %q{Woo your sweethearts with sms messages}
  spec.description   = %q{
This gem uses content from reddit to generate and dispatch sms messages to a
phone of your choosing.
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
  spec.add_runtime_dependency "googl", "~> 0.6"

  spec.add_development_dependency "bundler", "~> 1.6"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "foreman"

end
