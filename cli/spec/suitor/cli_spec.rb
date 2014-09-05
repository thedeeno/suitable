require 'suitor/cli'
require 'ostruct'

module Suitor
  describe Cli do
    include OutputCapture

    before do
      allow(Suitor).to receive(:charm) { OpenStruct.new(message: "works") }
    end

    let(:command) { described_class.new }
    let(:invalid_arguments) { [] }
    let(:valid_arguments) { [valid_number] }
    let(:valid_number) { MAGIC_NUMBERS[:valid] }
    let(:valid_subreddit) { "doge" }

    it "outputs confirmation message" do
      command.phone_number = valid_number
      command.execute
      expect(stdout).to match(/swooned/i)
    end

    it "sends phone number to Suitor facade" do
      command.phone_number = valid_number
      expect(Suitor).to receive(:charm).with(valid_number, with: nil)
      command.execute
    end

    it "sends subreddit to Suitor facade" do
      command.phone_number = valid_number
      command.subreddit = valid_subreddit
      expect(Suitor).to receive(:charm).with(valid_number, with: valid_subreddit)
      command.execute
    end

    it "raises system exit when given bad args" do
      expect do
        described_class.run(invalid_arguments)
      end.to raise_error(SystemExit)
    end

    context "when environment is incomplete" do
      before do
        @original = ENV["TWILIO_SID"]
        ENV["TWILIO_SID"] = ""
      end
      after do
        ENV["TWILIO_SID"] = @original
      end

      it "complains" do
        command.phone_number = valid_number
        expect do
          command.execute
        end.to raise_error(SystemExit)
      end
    end

  end
end
