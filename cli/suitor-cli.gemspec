Gem::Specification.new do |spec|
  spec.name          = "suitor-cli"
  spec.version       = "0.0.2"
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

  spec.add_runtime_dependency "suitor"
  spec.add_runtime_dependency "clamp", "~> 0.6"
  spec.add_runtime_dependency "dotenv"

  spec.add_development_dependency "bundler", "~> 1.6"
  spec.add_development_dependency "rake"
end
