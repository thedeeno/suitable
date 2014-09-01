require 'sinatra/base'
require 'sinatra/json'
require 'suitor'
require 'haml'

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
  end
end
