class Lf::Formatter::LTSV < Lf::Formatter
  Lf::Formatter[:ltsv] = self

  def self.format(row)
    fields = []

    row.each_pair do |label, val|
      fields << "#{green(label.to_s)}:#{cyan(val.to_s)}"
    end

    fields.join("\t")
  end
end
