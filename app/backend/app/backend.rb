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
    set :static, true

    get '/' do
      charm = App::Charm.new
      haml :index, locals: { charm: charm }
    end

    post '/charm' do
      charm = App::Charm.new(params)
      charm.submit
      haml :index, locals: { charm: charm }
    end

    configure :development do
      Dotenv.load ".env.development"
    end

    configure :test do
      Dotenv.load ".env.test"
    end

    # abort start when environment is not properly configured
    configure do
      Dotenv.load ".env"
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
