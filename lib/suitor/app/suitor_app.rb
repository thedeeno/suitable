require 'sinatra/base'
require 'sinatra/json'

module Suitor
module App

  class SuitorApp < Sinatra::Base
    helpers Sinatra::JSON
    set :views, File.join(settings.root, "templates")
    set :haml, format: :html5

    get '/' do
      haml :index
    end

  end

end
end

