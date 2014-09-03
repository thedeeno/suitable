describe "API:" do
  include Rack::Test::Methods

  def app
    Suitor::Backend
  end

  before do
    # stub the suitor facade
    allow(Suitor).to receive(:charm) { Suitor::SMS.new(message: "foo") }
  end

  describe "GET /" do
    before do
      get "/"
    end

    it "responds ok" do
      expect(last_response).to be_ok
    end

    it "responds with html" do
      expect(last_response.header['Content-Type']).to eq("text/html;charset=utf-8")
    end

    it "shows the charm form" do
      expect(last_response.body).to include("charm-form")
    end

    it "doesn't show dispatch error" do
      expect(last_response.body).to_not include("dispatch-error")
    end

    it "doesn't show dispatch success" do
      expect(last_response.body).to_not include("dispatch-success")
    end

    it "doesn't show last charm message" do
      expect(last_response.body).to_not include("last-charm-message")
    end
  end

  describe "POST /charm [HTML]" do
    let(:valid_params) {{ phone_number: "5556667777" }}
    let(:klass) { Suitor::App::Charm  }
    let(:charm) { klass.new }

    before do
      charm # eager load so we can stub
      allow(klass).to receive(:new) { charm }
    end

    context "when valid" do
      before do
        allow(charm).to receive(:valid?) { true }
      end

      context "and dispatch fails" do
        before do
          allow(Suitor).to receive(:charm).and_raise(Suitor::TwilioError)
          post "/charm"
        end

        it "responds with html" do
          expect(last_response.header['Content-Type']).to eq("text/html;charset=utf-8")
        end

        it "responds with 400" do
          expect(last_response.status).to eq(400)
        end

        it "shows dispatch error" do
          expect(last_response.body).to include("dispatch-error")
        end
      end

      context "and dispatch succeeds" do
        let(:message) { "the actual message" }
        before do
          allow(charm).to receive(:dispatched?) { true }
          allow(charm).to receive(:message) { message }
          post "/charm"
        end

        it "responds with html" do
          expect(last_response.header['Content-Type']).to eq("text/html;charset=utf-8")
        end

        it "responds ok" do
          expect(last_response).to be_ok
        end

        it "shows dispatch success" do
          expect(last_response.body).to include("dispatch-success")
        end

        it "shows dispatched charm" do
          expect(last_response.body).to include(message)
        end
      end

    end

    context "when invalid" do

      before do
        allow(charm).to receive(:valid?) { false }
        post "/charm"
      end

      it "responds 400" do
        expect(last_response.status).to eq(400)
      end

    end
  end

  describe "POST /charm [XHR]" do
    let(:headers) {{
      "HTTP_X_REQUESTED_WITH" => "XMLHttpRequest"
    }}
    let(:valid_params) {{ phone_number: "5556667777" }}

    it "responds with json" do
      post "/charm", valid_params, headers
      expect(last_response.header['Content-Type']).to eq("application/json")
    end

    it "returns message" do
      post "/charm", valid_params, headers
      data = JSON.parse(last_response.body)
      expect(data.keys).to include("message")
      expect(data["message"]).to_not be_empty
    end

    context "invalid params" do
      let(:invalid_params) { {} }

      it "responds with 400" do
        invalid_params = {}
        post "/charm", invalid_params, headers
        expect(last_response.status).to eq(400)
      end

      it "responds with json" do
        post "/charm", valid_params, headers
        expect(last_response.header['Content-Type']).to eq("application/json")
      end
    end

    context "when charm fails to dispatch" do
      before do
        allow(Suitor).to receive(:charm).and_raise(Suitor::TwilioError)
      end

      it "responds with 400" do
        post "/charm", valid_params, headers
        expect(last_response.status).to eq(400)
      end

      it "responds with json" do
        post "/charm", valid_params, headers
        expect(last_response.header['Content-Type']).to eq("application/json")
      end
    end
  end
end
