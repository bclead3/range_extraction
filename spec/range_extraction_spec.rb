
require 'range_extraction'
require 'byebug'

RSpec.describe RangeExtraction do

  describe '#solution' do
    let(:arr) { [-10, -9, -8, -6, -3]}
    it 'works for small range' do
      expect(subject.solution(arr)).to eq('-10--8,-6,-3')
    end
  end

  describe '#solution' do
    let(:arr) { [-10, -9, -8, -6, -3, -2, -1, 0, 1, 3, 4, 5, 7, 8, 9, 10, 11, 14, 15, 17, 18, 19, 20] }
    it 'works for full range' do
      expect(subject.solution(arr)).to eq('-10--8,-6,-3-1,3-5,7-11,14,15,17-20')
    end
  end
end
