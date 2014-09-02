require_relative 'suitor/errors'
require_relative 'suitor/composer'

require_relative 'suitor/models/sms'

require_relative 'suitor/services/reddit'
require_relative 'suitor/services/twilio'

module Suitor
  class << self
    def twilio
      @twilio ||= Twilio.new
    end

    def reddit
      @reddit ||= Reddit.new
    end

    # Composes charm using optional source material and dispatches
    # it to given phone number.
    #
    # @param [String] number The phone number to dispatch message to
    # @option options [String] :with The subreddit to use for source material.
    def charm(number, options={})
      subreddit = options[:with] if options
      msg = reddit.compose_from(subreddit)
      twilio.dispatch({
        to: number,
        body: msg,
      })
    end
  end
end
