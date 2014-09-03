module Suitor
module App

  describe Charm do
    let(:valid_phone_number) { "1112223333" }
    let(:valid_subreddit) { "romance" }

    describe ".phone_pattern" do
      it "matches numbers with +" do
        expect(Charm.phone_pattern).to match("+5556667777")
      end
      it "matches 10 digit numbers" do
        expect(Charm.phone_pattern).to match("5556667777")
      end
      it "matches 11 digit numbers" do
        expect(Charm.phone_pattern).to match("15556667777")
      end
      it "doesn't match too few digits" do
        expect(Charm.phone_pattern).to_not match("567777")
      end
      it "doesn't match when characters are present" do
        expect(Charm.phone_pattern).to_not match("a567777")
      end
    end

    describe "construction" do
      it "plucks 'phone_number'" do
        charm = Charm.new(phone_number: valid_phone_number)
        expect(charm.phone_number).to eq(valid_phone_number)
      end
      it "plucks 'subreddit'" do
        charm = Charm.new(subreddit: valid_subreddit)
        expect(charm.subreddit).to eq(valid_subreddit)
      end
      it "configures defaults" do
        charm = Charm.new
        expect(charm).to_not be_submitted
        expect(charm).to_not be_dispatched
        expect(charm).to_not be_invalid
        expect(charm.sms).to be_nil
        expect(charm.dispatch_error).to be_nil
      end
      it "strips dashes from phone_number" do
        charm = Charm.new(phone_number: "215-555-6667")
        expect(charm.phone_number).to eq("2155556667")
      end
      it "strips spaces from phone_number" do
        charm = Charm.new(phone_number: "215 555 6667")
        expect(charm.phone_number).to eq("2155556667")
      end
    end

    describe "#valid_phone_number" do
      it "returns false when phone number is nil" do
        charm = Charm.new(phone_number: nil)
        expect(charm).to_not have_valid_phone_number
      end
      it "returns false when phone number is empty" do
        charm = Charm.new(phone_number: "")
        expect(charm).to_not have_valid_phone_number
      end
      it "returns false when phone number fails to match pattern" do
        charm = Charm.new(phone_number: "asf")
        expect(charm).to_not have_valid_phone_number
      end
      it "returns true when number is valid" do
        charm = Charm.new(phone_number: "5556667777")
        expect(charm).to have_valid_phone_number
      end
    end

    describe "#validate" do
      context "when given invalid phone number" do
        let(:charm) { Charm.new(phone_number: "bad_input") }

        it "charm is invalid" do
          charm.validate
          expect(charm).to be_invalid
        end

        it "charm has a validation message" do
          charm.validate
          expect(charm.validation_message).to_not be_nil
        end
      end
    end

    describe "#submit" do
      let(:charm) { Charm.new }

      it "asks the suitor facade to send charm" do
        allow(Suitor).to receive(:charm)
        expect(Suitor).to receive(:charm).once
        charm.submit
      end

      it "doesn't attempt to send charm when invalid" do
        allow(Suitor).to receive(:charm)
        allow(charm).to receive(:valid?) { false }

        expect(Suitor).to_not receive(:charm)
        charm.submit
      end

      context "when invalid" do
        specify "charm is not submitted" do
          allow(Suitor).to receive(:charm)
          allow(charm).to receive(:valid?) { false }
          charm.submit
          expect(charm).to_not be_submitted
        end
      end

      context "when valid and dispatch successful" do
        let(:message) { "foo bar" }
        let(:charm) { Charm.new }

        before do
          allow(Suitor).to receive(:charm).and_return(SMS.new)
          charm.submit
        end

        it "charm is submitted" do
          charm.submit
          expect(charm).to be_submitted
        end

        it "charm is dispatched" do
          expect(charm).to be_dispatched
        end

        it "charm has sms" do
          expect(charm.sms).to_not be_nil
        end
      end

      context "when valid and dispatch failed" do
        let(:charm) { Charm.new }

        before do
          allow(Suitor).to receive(:charm).and_raise(SuitorError.new)
          charm.submit
        end

        it "charm is submitted" do
          charm.submit
          expect(charm).to be_submitted
        end

        it "charm is not dispatched" do
          expect(charm).to_not be_dispatched
        end

        it "charm has dispatch error" do
          expect(charm.dispatch_error).to_not be_empty
        end
      end
    end

    describe "#to_json" do
      it "includes message" do
        sms = double('sms')
        allow(sms).to receive(:message) { "foo" }
        charm = Charm.new
        charm.sms = sms
        expect(charm.to_json[:message]).to eq("foo")
      end
    end
  end

end
end

