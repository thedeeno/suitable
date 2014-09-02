# TODO: only if in development
require 'rack-livereload'
use Rack::LiveReload

require_relative 'app/backend'
run Suitor::Backend
