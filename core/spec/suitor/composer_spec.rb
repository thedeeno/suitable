require 'ostruct'

module Suitor

  describe Composer do
    let(:composer) { described_class.new }
    let(:shortener) { double("shortener") }

    before do
      allow(shortener).to receive(:shorten) { OpenStruct.new(short_url: "sho.rt/asdf") }
      allow(Googl).to receive(:new) { shortener }
    end

    it "adds the link title to message" do
      link = OpenStruct.new(url: "love.com", title: "foo")
      expect(composer.compose(link)).to include("foo")
    end

    it "shortens links in message" do
      link = OpenStruct.new(url: "love.com", title: "foo")
      expect(composer.compose(link)).to eq("foo\nsho.rt/asdf")
    end
  end

end
