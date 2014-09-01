module Suitor
module Acceptance
  class AppDescriptor
    attr_reader :uri

    def initialize(uri)
      @uri = uri
    end

    def available?
      return false unless valid_uri?
      TCPSocket.new(uri.host, uri.port).close
      true
    rescue SocketError
      false
    rescue Errno::ECONNREFUSED
      false
    end

    def host; uri.host; end
    def port; uri.port; end

    def valid_uri?
      host and port
    end

    def inspect
      "{App: #{uri}}"
    end

    def to_s
      uri.to_s
    end

    def home
      uri
    end
  end
end
end
