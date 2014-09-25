require 'term/ansicolor'
require 'lf'

class Lf::Formatter
  extend Term::ANSIColor

  FORMATTERS = {}

  def self.[](name)
    FORMATTERS[name]
  end

  def self.[]=(name, klass)
    FORMATTERS[name.to_s.to_sym] = klass
  end
end

Dir.glob(::File.expand_path('../formatter/*.rb', __FILE__)).each do |f|
  require_relative f
end
