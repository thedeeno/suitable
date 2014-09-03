describe Suitor do
  describe ".charm" do
    let(:valid_number) { MAGIC_NUMBERS[:valid] }

    it "asks reddit to create message from subreddit" do
      source = "doge"

      expect(Suitor.reddit).to receive(:compose_from)
        .with(source).and_return("foo bar")

      Suitor.charm(valid_number, with: source)
    end

    it "tells twilio to dispatch composed message to given number" do
      allow(Suitor.reddit).to receive(:compose_from) { "foo bar" }

      expect(Suitor.twilio).to receive(:dispatch)
        .with({ to: valid_number, body: "foo bar" })

      Suitor.charm(valid_number)
    end

    it "wraps twilio request errors" do
      allow(Suitor.twilio).to receive(:dispatch).and_raise(Twilio::REST::RequestError.new(""))
      expect do
        Suitor.charm(valid_number)
      end.to raise_error(Suitor::TwilioError)
    end
  end
end
