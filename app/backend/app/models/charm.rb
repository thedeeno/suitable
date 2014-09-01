require 'ostruct'

module Suitor
module App
  # Represents the user-space form for submitting charms.
  #
  # This is muteable - tracking validation, dispatch, and response. Not the
  # cleanest perhaps, but straightforward.
  class Charm
    def initialize(options={})

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

    def submit
      return if submitted?
      @submitted = true
    end

    def invalid?
      !valid?
    end

    def valid?
      true
    end

    def submitted?
      false
    end

    def dispatched?
      false
    end

    def dispatch_error
      ""
    end

    def validation_message
      ""
    end

    def failed_dispatch?
      submitted? and !dispatched?
    end

    def message
      ""
    end
  end
end
end

