describe Lf::Row do
  subject(:row) { described_class.new(ltsv_line) }

  describe '#initialize' do
    let(:ltsv_line) { "tag1:foo\ttag2:bar\n" }

    it 'should be ok' do
      expect(row).to be_a described_class
      expect(row).to have_key(:tag1)
      expect(row).to have_key(:tag2)
    end
  end

  describe '#to_s' do
    let(:ltsv_line) { 'tag1:foo' }
    subject(:to_s) { row.to_s }

    it { expect(to_s).to eq('tag1:foo') }
  end
end
