require 'ltsv'
require 'delegate'
require 'term/ansicolor'
require 'terminal-table'
require 'lf'

class Lf::Row < SimpleDelegator
  include Term::ANSIColor

  def initialize(line)
    @raw = LTSV.parse(line.to_s.chomp)[0]
    super(@raw)
  end

  def to_s(format = :ltsv)
    case format.to_s.to_sym
    when :table
      to_s_with_table
    else
      to_s_with_ltsv
    end
  end

  private

  def to_s_with_table
    rows = []
    @raw.each_pair do |label, val|
      rows << [green(label.to_s), cyan(val.to_s)]
    end
    Terminal::Table.new(rows: rows).to_s
  end

  def to_s_with_ltsv
    cols = []
    @raw.each_pair do |label, val|
      cols << "#{green(label.to_s)}:#{cyan(val.to_s)}"
    end
    cols.join("\t")
  end
end
