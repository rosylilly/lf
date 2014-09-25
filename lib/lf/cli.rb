require 'lf'

class Lf::CLI
  def initialize(argv, stdin = STDIN, stdout = STDOUT, stderr = STDERR, kernel = Kernel)
    @argv, @stdin, @stdout, @stderr, @kernel = argv, stdin, stdout, stderr, kernel

    @stream = Lf::Stream.new(@stdin, @stdout)
  end

  def execute!
    @stream.process

    @kernel.exit(0)
  end
end
