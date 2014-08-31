require 'twilio-ruby'

module Suitor

  class Twilio
    def sid
      ENV["TWILIO_SID"]
    end

    def token
      ENV["TWILIO_TOKEN"]
    end

    def client
      @client ||= ::Twilio::REST::Client.new(sid, token)
    end

    def defaults
      { from: ENV["FROM_PHONE"] }
    end

    def dispatch(options)
      options = defaults.merge(options)
      client.account.messages.create(options)
    end
  end

end
