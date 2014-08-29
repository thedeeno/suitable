require 'suitor/cli'
require 'open3'

describe "Suitor CLI" do
  let(:command) { Suitor::Cli::Command.new("suitor") }
  let(:valid_args) { "#{MAGIC_NUMBERS[:valid]}" }

  def run_suitor(arg_string)
    Open3.capture2e("bundle exec ./bin/suitor #{arg_string}")
  end

  it "successfully sends a message when given valid args" do
    output, status = run_suitor(valid_args)
    expect(output).to match(/swooned/i)
    expect(status).to eq(0)
  end

  it "exits non-zero when missing number" do
    output, status = run_suitor("")
    expect(status).to_not eq(0)
  end

  it "exits non-zero when given bad number" do
    output, status = run_suitor(MAGIC_NUMBERS[:invalid])
    expect(status).to_not eq(0)
  end

end
