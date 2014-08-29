require 'ostruct'

module Suitor
module Core
  describe Reddit do
    let(:reddit) { Reddit.new }

    describe "#top_link" do
      it "returns link from given subreddit" do
        expect(reddit.top_link("romance").subreddit).to eq("romance")
      end

      context "when given no subreddit" do
        it "returns link from front page" do
          expect(reddit.top_link.subreddit).to_not be_empty
        end
      end

      it "complains when subreddit doesn't exists" do
        bad_subreddit = "d4b169948aeb4ff9b93840bf474fefb2"
        expect do
          reddit.top_link(bad_subreddit)
        end.to raise_error(SubRedditNotFound)
      end
    end
  end

end
end
