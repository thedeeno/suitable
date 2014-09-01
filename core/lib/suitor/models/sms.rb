module Suitor
  # Wrapper for twilio's sms message class
  class SMS
    attr_reader :twilio_sms
    def initialize(twilio_sms=nil)
      @twilio_sms=twilio_sms
    end
  end
end

