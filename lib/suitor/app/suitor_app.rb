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

    post '/charm' do
      error 400, "missing phone number" unless params[:phone_number]
      sms = Suitor.charm(params[:phone_number])
      json sms.to_json
    end
  end

end
end

