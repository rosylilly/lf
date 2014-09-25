class Lf::Filter::Eq < Lf::Filter
  filter_alias :equal

  def initialize(arg)
    @label, @value = *arg.split(':')
  end

  def apply(row)
    row[@label.to_s.to_sym].to_s == @value ? row : nil
  end
end
