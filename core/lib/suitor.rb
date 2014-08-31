require_relative 'suitor/errors'

require_relative 'suitor/services/reddit'
require_relative 'suitor/services/twilio'

require_relative 'suitor/models/message'

require_relative 'suitor/composer'

module Suitor
  class << self
    def twilio
      @twilio ||= Twilio.new
    end

    def reddit
      @reddit ||= Reddit.new
    end

    def composer
      @composer ||= Composer.new(reddit)
    end

    # Composes charm using optional source material and dispatches
    # it to given phone number.
    #
    # @param [String] number The phone number to dispatch message to
    # @option options [String] :with The subreddit to use for source material.
    def charm(number, options={})
      subreddit = options[:with] if options
      msg = composer.compose(subreddit)
      twilio.dispatch({
        to: number,
        body: msg,
      })
    end
  end
end
