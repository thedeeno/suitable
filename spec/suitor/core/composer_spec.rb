require 'ostruct'

module Suitor
module Core
  describe Composer do

    it "generates message from top link in subreddit" do
      reddit = double("Reddit")
      allow(reddit)
        .to receive(:top_link)
        .with("romance")
        .and_return(OpenStruct.new(url: "love.com", title: "foo"))

      composer = Composer.new(reddit)
      actual = composer.compose("romance")
      expected = Message.new(title: "foo", url: "love.com")

      expect(actual).to eq(expected)
    end
  end

end
end
