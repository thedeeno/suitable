require_relative 'suitor/core'

module Suitor
  class << self
    def twilio
      @twilio ||= Core::Twilio.new
    end

    def reddit
      @reddit ||= Core::Reddit.new
    end

    def composer
      @composer ||= Core::Composer.new(reddit)
    end

    # Composes charm using optional source material and dispatches
    # it to given phone number.
    #
    # @option options [String] :with The subreddit to use for source material.
    def charm(number, options={})
      subreddit = options[:with]
      msg = composer.compose(subreddit)
      twilio.dispatch({
        to: number,
        body: msg,
      })
    end
  end
end
