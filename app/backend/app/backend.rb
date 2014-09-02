require 'sinatra/base'
require 'sinatra/json'
require 'suitor'
require 'haml'
require 'dotenv'

require_relative "models/charm"

module Suitor

  class Backend < Sinatra::Base
    helpers Sinatra::JSON
    set :views, File.join(settings.root, "templates")
    set :haml, format: :html5

    get '/' do
      charm = App::Charm.new
      haml :index, locals: { charm: charm }
    end

    post '/charm' do
      charm = App::Charm.new(params)
      charm.submit
      haml :index, locals: { charm: charm }
    end

    # abort start when environment is not properly configured
    configure do
      %w[
        TWILIO_TOKEN
        TWILIO_SID
        FROM_PHONE
        REDDIT_KIT_USER
        REDDIT_KIT_PASS
      ].each do |key|
        abort "Incomplete environment: #{key} not set" if ENV[key].nil? or ENV[key].empty?
      end
    end

  end
end
