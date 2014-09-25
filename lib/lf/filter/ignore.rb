class Lf::Filter::Ignore < Lf::Filter
  def initialize(arg)
    @labels = arg.split(',').map(&:strip)
  end

  def apply(row)
    raw = row.reject do |key, _|
      @labels.include?(key.to_s)
    end

    Lf::Row.new(raw)
  end
end
