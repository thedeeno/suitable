describe Suitor do
  describe ".charm" do
    let(:valid_number) { MAGIC_NUMBERS[:valid] }

    it "asks composer to write message with given source material" do
      source = "doge"

      expect(Suitor.composer).to receive(:compose)
        .with(source).and_return("foo bar")

      Suitor.charm(valid_number, with: source)
    end

    it "tells twilio to dispatch composed message to given number" do
      message = "foo bar"
      allow(Suitor.composer).to receive(:compose).and_return(message)

      expect(Suitor.twilio).to receive(:dispatch)
        .with({ to: valid_number, body: message })

      Suitor.charm(valid_number)
    end
  end
end
