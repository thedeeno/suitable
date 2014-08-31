ENV['RACK_ENV'] = 'test'

require 'rack/test'
require 'json'

require_relative '../app'

describe "Suitor API" do
  include Rack::Test::Methods

  def app
    Suitor::App
  end

  before do
    # stub the suitor facade
    allow(Suitor).to receive(:charm) { true }
  end

  describe "GET /" do
    it "says hello world" do
      get "/"
      expect(last_response).to be_ok
      expect(last_response.body).to match(/hello world/i)
    end
  end

  describe "POST /charm" do
    let(:valid_params) {{ phone_number: "5556667777" }}

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
