require 'childprocess'

Given(/^the suitor app is available$/) do
  ChildProcess.posix_spawn = true
  @server = ChildProcess.build("bundle","exec","rackup","config.ru","-E","test","-p","9230")
  outfile = Tempfile.new("suitor-test-server-output")
  @server.io.stdout = @server.io.stderr = outfile
  # @server.io.inherit!
  @server.leader = true
  @server.environment["BUNDLE_GEMFILE"] = "../../app/backend/Gemfile"
  @server.cwd = "../app/backend"
  @server.start

  uri = URI.parse("http://localhost:9230")
  @app = Suitor::Acceptance::AppDescriptor.new(uri)
  expect(@app).to be_available(5), "Suitor app is not available at #{@app}\n"
end
