require 'timeout'

module Suitor
module Acceptance
  class AppDescriptor
    attr_reader :uri

    def initialize(uri)
      @uri = uri
    end

    def available?(timeout)
      return false unless valid_uri?
      up = false
      begin
        Timeout::timeout(timeout) do
          while not up do
            begin
              TCPSocket.new(uri.host, uri.port).close
              up = true
            rescue SocketError
              up = false
            rescue Errno::ECONNREFUSED
              up = false
            end
          end
        end
      rescue Timeout::Error
        return false
      end
      return up
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
