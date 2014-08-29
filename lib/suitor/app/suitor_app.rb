require 'sinatra/base'

module Suitor
module App

  class SuitorApp < Sinatra::Base

    get '/' do
      "Hello World"
    end

  end

end
end

