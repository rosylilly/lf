require 'lf'
require 'lf/row'

class Lf::Stream
  def initialize(input, output)
    @input, @output = input, output
  end

  def process
    loop do
      line = @input.gets
      break unless line
      row = Lf::Row.new(line)
      @output.puts row.to_s
      @output.flush
    end
  end
end
