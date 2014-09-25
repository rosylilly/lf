require 'lf'

class Lf::Filter
  FILTERS = {}

  def self.inherited(klass)
    Lf::Filter[klass.name.sub(/.*::/, '').downcase] = klass
  end

  def self.filter_alias(name)
    Lf::Filter[name] = self
  end

  def self.[](name)
    FILTERS[name.to_s.to_sym]
  end

  def self.[]=(name, klass)
    FILTERS[name.to_s.to_sym] = klass
  end

  def self.parse(argv)
    filters = []

    argv.each do |arg|
      arg = arg.sub(/^([^:]*):/, '')
      if ::Regexp.last_match && ::Regexp.last_match[1]
        name = ::Regexp.last_match[1].to_s.to_sym
        filters << self[name].new(arg) if self[name]
      end
    end

    filters
  end

  def initialize(arg)
    @arg = arg
  end

  def apply(row)
    row
  end
end

Dir.glob(::File.expand_path('../filter/*.rb', __FILE__)).each do |f|
  require_relative f
end
