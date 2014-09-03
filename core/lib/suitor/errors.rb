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
    def initialize(original)
      @original = original
      super("Problem sending text message")
    end
  end
end

