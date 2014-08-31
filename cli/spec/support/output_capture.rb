# Capture and provide convenient access to output stream content
# when included in an example group
module OutputCapture
  def self.included(target)
    target.before do
      $stdout = @out = StringIO.new
      $stderr = @err = StringIO.new
    end
    target.after do
      $stdout = STDOUT
      $stderr = STDERR
    end
  end
  def stdout
    @out.string
  end
  def stderr
    @err.string
  end
end
