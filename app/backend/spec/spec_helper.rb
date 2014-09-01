ENV['RACK_ENV'] = 'test'

require 'rack/test'
require 'json'

require_relative '../app/backend'
