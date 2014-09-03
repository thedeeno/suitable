source "https://rubygems.org"

gem "sinatra", "~> 1.4"
gem "sinatra-contrib", "~> 1.4"
gem "haml", "~> 4"
gem "suitor", path: "core"
gem "unicorn"

group :test do
  gem "rspec", "~> 3.0"
  gem "rack-test"
end

group :development, :test do
  gem "pry"
  gem "rack-livereload"
end
