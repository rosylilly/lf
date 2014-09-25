class Lf::Formatter::Table < Lf::Formatter
  Lf::Formatter[:table] = self

  def self.format(row)
    field_size = row.keys.map(&:to_s).sort_by(&:length).last.to_s.size + 1

    fields = []
    row.each_pair do |label, val|
      fields << "#{green(label.to_s.ljust(field_size))}: #{cyan(val.to_s)}"
    end

    "----\n" + fields.join("\n")
  end
end
