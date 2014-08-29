module Suitor
module Core
  class SubRedditNotFound < StandardError
    def initialize(subreddit)
      super("The subreddit '#{subreddit}' was not found")
    end
  end
end
end

