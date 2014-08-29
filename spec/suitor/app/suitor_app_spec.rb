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
    it "says hello world" do
      get "/"
      expect(last_response).to be_ok
      expect(last_response.body).to match(/hello world/i)
    end
  end

  describe "POST /charm" do
    let(:valid_params) {{ phone_number: MAGIC_NUMBERS[:valid] }}

    it "returns json by default" do
      post "/charm", valid_params
      expect(last_response.header['Content-Type']).to eq("application/json")
    end

    it "responds ok when valid params are supplied" do
      post "/charm", valid_params
      expect(last_response).to be_ok
    end

    it "requires phone_number" do
      post "/charm", valid_params.reject{|k,v| k == :phone_number}
      expect(last_response.status).to eq(400)
    end

  end
end

end
