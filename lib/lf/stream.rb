require 'lf'
require 'lf/row'

class Lf::Stream
  def initialize(input, output, option)
    @input, @output, @option = input, output, option
  end

  def process
    loop do
      line = @input.gets
      break unless line
      row = Lf::Row.new(line)
      row = @option.filters.reduce(row) { |a, e| a && e.apply(a) }
      @output.puts(row.to_s(@option[:format])) if row
      @output.flush unless @option[:buffered]
    end
  end
end
