require 'redditkit'

module Suitor

  class Reddit
    def client
      @client ||= RedditKit::Client.new ENV["REDDIT_KIT_USER"], ENV["REDDIT_KIT_PASS"]
    end

    def composer
      @composer ||= Composer.new
    end

    # Returns the top link from the given subreddit
    def top_link(sub=nil)
      raise SubRedditNotFound.new(sub) if sub and client.subreddit(sub).nil?
      client.links(sub).first
    end

    # Composes a message using the given subreddit as inspiration
    #
    # @returns [String] the message
    def compose_from(subreddit)
      composer.compose(top_link(subreddit))
    end
  end

end
