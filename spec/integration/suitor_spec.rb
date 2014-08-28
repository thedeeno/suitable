require 'spec_helper'

describe "SXTing top /r/romance topic" do
  it "successfully sends a message" do
    io = IO.popen(File.join File.dirname(__FILE__), "../../bin/suitor")
    output = io.readlines.join(' ')
    expect(output).to match(/swooned/i)
  end
end
