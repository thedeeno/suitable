module Suitor
  # Wrapper for twilio's sms message class
  class SMS
    # Factory method to create sms form twilio sms
    def self.from_twilio(sms)
      new(message: sms.body)
    end

    attr_reader :message

    def initialize(options={})
      @message=options[:message]
    end

  end
end

