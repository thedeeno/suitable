require 'clamp'
require 'suitor'

module Suitor
module Cli

  class Command < Clamp::Command
    def initialize(*args)
      super("suitor", *args)
    end

    option ["-s", "--subreddit"], "[SUBREDDIT]", "The subreddit to use for source material"

    parameter "PHONE_NUMBER", "the phone number to charm"

    def execute
      Suitor.charm(phone_number, subreddit)
      puts "Swooned #{phone_number}"
    end
  end

end
end
