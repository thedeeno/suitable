require 'ostruct'

module Suitor
module App
  # Represents the user-space form for submitting charms.
  #
  # This is muteable - tracking validation, dispatch, and response. Not the
  # cleanest perhaps, but straightforward.
  class Charm
    def self.phone_pattern
      @phone_pattern ||= /\+?\d{10,11}(?:x\d+)?/
    end

    # params
    attr_reader :phone_number, :subreddit

    # state
    attr_reader :submitted,
      :dispatched,
      :dispatch_error,
      :validation_message

    attr_accessor :sms

    def initialize(options={})
      @phone_number = options[:phone_number]
      @subreddit = options[:subreddit] || "romance"
      @submitted = false
      @dispatched = false
      @dispatch_error = nil
      @validation_message = nil
      @valid = true
    end

    def [](key)
      fields[key]
    end

    def fields
      {
        phone_number: OpenStruct.new({
          state: "invalid",
          message: "phone number is invalid",
          value: "5556668888"
        })
      }
    end

    def message
      return @validation_message if @validation_message
      return @dispatch_error if @dispatch_error
      sms.message
    end

    def submit
      return unless valid?
      @submitted = true
      @dispatch_error = nil

      begin
        @sms = Suitor.charm(phone_number, with: subreddit)
        @dispatched = true
      rescue RedditError
        @dispatch_error = "Error composing message. Does your subreddit have posts?"
      rescue TwilioError, SuitorError
        @dispatch_error = "Error sending text message"
      end
    end

    def invalid?
      !valid?
    end

    def valid?
      @valid
    end

    def validate
      if has_valid_phone_number?
        @valid = true
      else
        @validation_message = "Invalid Phone Number"
        @valid = false
      end
    end

    def has_valid_phone_number?
      return false if phone_number.nil?
      return false if phone_number.empty?
      return false unless phone_number.match(self.class.phone_pattern)
      true
    end

    def submitted?; @submitted; end
    def dispatched?; @dispatched; end

    def failed_dispatch?
      submitted? and !dispatched?
    end

    def to_json
      { message: message }
    end
  end
end
end

