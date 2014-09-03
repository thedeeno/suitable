require 'googl'

module Suitor

  # Service wrapper for the Googl url shortening service
  class Googl
    def client
      @client ||= ::Googl
    end

    # Returns a googl shortened version of given url
    def shorten(url)
      client.shorten(url)
    end
  end

end
