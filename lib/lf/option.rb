require 'optparse'
require 'lf'

class Lf::Option < ::OptionParser
  SUPPORTED_FORMATS = %w(ltsv table)

  def self.parse(*args)
    new(*args).tap { |option| option.parse!(option.argv) }
  end

  def initialize(argv, stdin, stdout)
    super()
    @argv, @input, @output = argv.dup, stdin, stdout
    @options = {
      format: 'ltsv'
    }

    configure_options
  end

  attr_reader :argv, :input, :output

  def version
    Lf::VERSION
  end

  def banner
    'Usage: lf [options] <filters ...> [file]'
  end

  def show_help
    output.puts self
    exit 1
  end

  def parse!(*)
    super

    @input = open(@argv.pop, 'r') if File.file?(@argv.last.to_s)
  end

  def [](key)
    @options[key]
  end

  private

  # rubocop:disable MethodLength
  def configure_options
    on('-c', '--[no-]color', @input.isatty.class, 'Colored output') do |val|
      @options[:color] = val
    end

    on('-f FORMAT', '--format FORMAT', "Choose a format(#{SUPPORTED_FORMATS.join(', ')})") do |val|
      @options[:format] = val if SUPPORTED_FORMATS.include?(val)
    end

    on_tail('-h', '--help', 'Show this message') do
      show_help
    end

    on_tail('-v', '--version', 'Show version') do
      output.puts ver
      exit 2
    end
  end
  # rubocop:enable MethodLength
end
