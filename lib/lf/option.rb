require 'optparse'
require 'lf'
require 'lf/formatter'
require 'lf/filter'

class Lf::Option < ::OptionParser
  SUPPORTED_FORMATS = Lf::Formatter::FORMATTERS.keys

  def self.parse(*args)
    new(*args).tap { |option| option.parse!(option.argv) }
  end

  def initialize(argv, stdin, stdout)
    super()
    @argv, @input, @output = argv.dup, stdin, stdout
    @options = {
      format: 'ltsv'
    }
    @filters = []

    configure_options
  end

  attr_reader :argv, :input, :output, :filters

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
    @filters = Lf::Filter.parse(@argv)
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
      val = val.to_s.to_sym
      @options[:format] = val if SUPPORTED_FORMATS.include?(val)
    end

    on('-b', '--[no-]buffered', TrueClass, 'Flush the output after each LTSV row') do |val|
      @options[:buffered] = val
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
