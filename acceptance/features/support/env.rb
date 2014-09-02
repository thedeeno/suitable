require 'rspec'
require 'capybara'
require_relative 'visitor_agent'
require_relative 'app_descriptor'

# Get handle to world so we can stop the server at exit
class SuitorWorld
  def server
    @server
  end
end
world = SuitorWorld.new
World { world }

# Stop server at exit
at_exit do
  if world.server
    puts ""
    puts "killing test suitor server...\n"
    world.server.stop
  end
end
