module Suitor
  class SuitorError < StandardError; end;
  class RedditError < SuitorError; end;

  class SubRedditNotFound < RedditError
    def initialize(subreddit)
      super("The subreddit '#{subreddit}' was not found")
    end
  end

  class TwilioError < SuitorError
    attr_reader :original
    def initialize(original=nil)
      @original = original
      super("Problem sending text message")
    end

    def to_s
      "#{super}:\n#{@original}"
    end
  end
end

