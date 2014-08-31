require 'ostruct'

module Suitor

  describe Composer do
    let(:composer) { described_class.new }

    it "generates message from link" do
      link = OpenStruct.new(url: "love.com", title: "foo")
      expect(composer.compose(link)).to eq("foo love.com")
    end
  end

end
