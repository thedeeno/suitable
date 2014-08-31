require 'clamp'
require 'suitor'

module Suitor

  class Cli < Clamp::Command
    # Assume 'suitor' is the 'invocation_path' at construction time
    def initialize(*args)
      super("suitor", *args)
    end

    option ["-s", "--subreddit"], "[SUBREDDIT]", "The subreddit to use for source material"

    parameter "PHONE_NUMBER", "the phone number to charm"

    # Delegates to the Suitor facade and prints confirmation message
    def execute
      Suitor.charm(phone_number, subreddit)
      puts "Swooned #{phone_number}"
    end
  end

end
