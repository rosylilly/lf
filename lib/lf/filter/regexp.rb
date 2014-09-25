class Lf::Filter::Regexp < Lf::Filter
  filter_alias :reg

  def initialize(arg)
    @label, @value = *arg.split(':')
    @value = ::Regexp.new(@value)
  end

  def apply(row)
    row[@label.to_s.to_sym].match(@value) ? row : nil
  end
end
