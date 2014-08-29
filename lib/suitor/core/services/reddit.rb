require 'redditkit'

module Suitor
module Core

  class Reddit
    def client
      @client ||= RedditKit::Client.new ENV["REDDIT_KIT_USER"], ENV["REDDIT_KIT_PASS"]
    end

    def top_link(sub=nil)
      raise SubRedditNotFound.new(sub) if sub and client.subreddit(sub).nil?
      client.links(sub).first
    end
  end

end
end

