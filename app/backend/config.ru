if ENV['RACK_ENV'] == "development"
  require 'rack-livereload'
  use Rack::LiveReload
end

require_relative 'app/backend'
run Suitor::Backend
