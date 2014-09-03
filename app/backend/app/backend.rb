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

      charm.validate
      status 400 if charm.invalid?

      charm.submit
      status 400 if !charm.dispatched?

      if ajax_request?
        json charm.to_json
      else
        haml :index, locals: { charm: charm }
      end

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
      Suitor.check_environment!
    end

    private

    def ajax_request?
      request.env["HTTP_X_REQUESTED_WITH"] == "XMLHttpRequest"
    end

  end
end
