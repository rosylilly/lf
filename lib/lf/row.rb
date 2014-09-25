require 'ltsv'
require 'delegate'
require 'lf'
require 'lf/formatter'

class Lf::Row < SimpleDelegator
  attr_reader :raw

  def initialize(line)
    if line.is_a?(Hash)
      @raw = line
    else
      @raw = LTSV.parse(line.to_s.chomp)[0]
    end

    super(@raw)
  end

  def to_s(format = :ltsv)
    Lf::Formatter[format.to_s.to_sym].format(self)
  end
end
