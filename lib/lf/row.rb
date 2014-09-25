require 'ltsv'
require 'delegate'
require 'lf'

class Lf::Row < SimpleDelegator
  def initialize(line)
    @raw = LTSV.parse(line.to_s.chomp)[0]
    super(@raw)
  end

  def to_s
    LTSV.dump(@raw)
  end
end
