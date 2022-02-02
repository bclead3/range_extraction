
require 'lib/range_extraction'

RSpec.describe RangeExtraction do

  describe '#solution' do
    let(:arr) { [-10, -9, -8, -6, -3]}
    it 'works for small range' do
      expect(subject.solution(arr)).to eq('-10--8,-6,-3')
    end
  end
end
