require 'suitor/cli'

module Suitor
  describe Cli::Command do
    include OutputCapture

    let(:command) { described_class.new }
    let(:invalid_arguments) { [] }
    let(:valid_number) { MAGIC_NUMBERS[:valid] }
    let(:valid_subreddit) { "doge" }

    it "outputs confirmation message" do
      allow(Suitor).to receive(:charm) { true }
      command.phone_number = valid_number
      command.execute
      expect(stdout).to match(/swooned/i)
    end

    it "sends phone number to Suitor facade" do
      command.phone_number = valid_number
      expect(Suitor).to receive(:charm).with(valid_number, nil)
      command.execute
    end

    it "sends subreddit to Suitor facade" do
      command.phone_number = valid_number
      command.subreddit = valid_subreddit
      expect(Suitor).to receive(:charm).with(valid_number, valid_subreddit)
      command.execute
    end

    it "raises system exit when given bad args" do
      expect do
        described_class.run(invalid_arguments)
      end.to raise_error(SystemExit)
    end

  end
end
