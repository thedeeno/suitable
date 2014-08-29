ENV['RACK_ENV'] = 'test'

require 'rack/test'
require 'json'

require 'suitor/app'

module Suitor

describe "Synchrony API" do
  include Rack::Test::Methods

  def app
    App::SuitorApp
  end

  describe "GET /" do
    it "returns hello world" do
      get "/"
      expect(last_response.body).to match(/hello world/i)
    end
  end
end

end
