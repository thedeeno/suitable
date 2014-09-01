describe "API:" do
  include Rack::Test::Methods

  def app
    Suitor::Backend
  end

  before do
    # stub the suitor facade
    allow(Suitor).to receive(:charm) { true }
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

    it "doesn't show validation errors" do
      expect(last_response.body).to_not include("validation-errors")
    end

    it "doesn't show dispatch error" do
      expect(last_response.body).to_not include("dispatch-error")
    end

    it "doesn't show dispatch success" do
      expect(last_response.body).to_not include("dispatch-success")
    end

    it "doesn't show last charm" do
      expect(last_response.body).to_not include("last-charm")
    end
  end

  describe "POST /charm" do
    let(:valid_params) {{ phone_number: "5556667777" }}
    let(:klass) { Suitor::App::Charm  }
    let(:charm) { klass.new }

    before do
      charm # eager load so we can stub
      allow(klass).to receive(:new) { charm }
    end

    context "when valid" do
      before do
        allow(charm).to receive(:valid) { true }
      end

      it "responds ok" do
        post "/charm"
        expect(last_response.status).to eq(200)
      end

      it "responds with html" do
        post "/charm"
        expect(last_response.header['Content-Type']).to eq("text/html;charset=utf-8")
      end

      context "and dispatch fails" do
        before do
          allow(charm).to receive(:failed_dispatch?) { true }
          post "/charm"
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

      it "responds ok" do
        expect(last_response).to be_ok
      end

      it "shows user validation errors" do
        expect(last_response.body).to include("validation-errors")
      end

    end

  end
end
