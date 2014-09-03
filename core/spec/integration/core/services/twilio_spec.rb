module Suitor

  describe Twilio do
    let(:twilio) { described_class.new }
    let(:valid_options) {{
      from: MAGIC_NUMBERS[:valid],
      to:   MAGIC_NUMBERS[:valid],
      body: "foo"
    }}

    describe "#dispatch" do
      it "returns an sms message" do
        sms = twilio.dispatch(valid_options)
        expect(sms.message).to eq("foo")
      end

      context "when destination is invalid" do
        it "raises" do
          expect do
            twilio.dispatch(valid_options.merge(to: MAGIC_NUMBERS[:invalid]))
          end.to raise_error(::Twilio::REST::RequestError)
        end
      end
    end
  end

end
