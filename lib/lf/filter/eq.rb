class Lf::Filter::Eq < Lf::Filter
  Lf::Filter[:eq] = self

  def initialize(arg)
    @label, @value = *arg.split(':')
  end

  def apply(row)
    row[@label.to_s.to_sym] == @value ? row : nil
  end
end
