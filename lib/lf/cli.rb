require 'terminal-table'
require 'lf'
require 'lf/option'
require 'lf/stream'

class Lf::CLI
  def initialize(argv, stdin = STDIN, stdout = STDOUT, stderr = STDERR, kernel = Kernel)
    @argv, @stdin, @stdout, @stderr, @kernel = argv, stdin, stdout, stderr, kernel

    @option = Lf::Option.parse(@argv, @stdin, @stdout)
    @stream = Lf::Stream.new(@option.input, @option.output, @option)

  rescue => e
    @stderr.puts e.message
    @kernel.exit(1)
  end

  def execute!
    @stream.process

    @kernel.exit(0)
  end
end
