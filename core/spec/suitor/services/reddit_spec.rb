module Suitor

  describe Reddit do
    let(:reddit) { described_class.new }

    describe "#compose_from" do
      it "asks composer to create message from top link" do
        link = OpenStruct.new(url: "love.com", title: "foo")
        allow(reddit).to receive(:top_link) { link }
        expect(reddit.composer).to receive(:compose).with(link)

        reddit.compose_from("romance")
      end
    end
  end

end
