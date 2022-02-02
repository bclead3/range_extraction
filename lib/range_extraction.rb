require 'byebug'

class RangeExtraction

  # .{"0"=>{:val=>-10},
  #  "1"=>{:val=>-9, :prev_element=>-10, :diff=>1},
  #  "2"=>{:val=>-8, :prev_element=>-9, :diff=>1, :prev_diff=>1},
  #  "3"=>{:val=>-6, :prev_element=>-8, :diff=>2, :prev_diff=>1},
  #  "4"=>{:val=>-3, :prev_element=>-6, :diff=>3, :prev_diff=>2},
  #  "5"=>{:val=>-2, :prev_element=>-3, :diff=>1, :prev_diff=>3},
  #  "6"=>{:val=>-1, :prev_element=>-2, :diff=>1, :prev_diff=>1},
  #  "7"=>{:val=>0, :prev_element=>-1, :diff=>1, :prev_diff=>1},
  #  "8"=>{:val=>1, :prev_element=>0, :diff=>1, :prev_diff=>1},
  #  "9"=>{:val=>3, :prev_element=>1, :diff=>2, :prev_diff=>1},
  #  "10"=>{:val=>4, :prev_element=>3, :diff=>1, :prev_diff=>2},
  #  "11"=>{:val=>5, :prev_element=>4, :diff=>1, :prev_diff=>1},
  #  "12"=>{:val=>7, :prev_element=>5, :diff=>2, :prev_diff=>1},
  #  "13"=>{:val=>8, :prev_element=>7, :diff=>1, :prev_diff=>2},
  #  "14"=>{:val=>9, :prev_element=>8, :diff=>1, :prev_diff=>1},
  #  "15"=>{:val=>10, :prev_element=>9, :diff=>1, :prev_diff=>1},
  #  "16"=>{:val=>11, :prev_element=>10, :diff=>1, :prev_diff=>1},
  #  "17"=>{:val=>14, :prev_element=>11, :diff=>3, :prev_diff=>1},
  #  "18"=>{:val=>15, :prev_element=>14, :diff=>1, :prev_diff=>3},
  #  "19"=>{:val=>17, :prev_element=>15, :diff=>2, :prev_diff=>1},
  #  "20"=>{:val=>18, :prev_element=>17, :diff=>1, :prev_diff=>2},
  #  "21"=>{:val=>19, :prev_element=>18, :diff=>1, :prev_diff=>1},
  #  "22"=>{:val=>20, :prev_element=>19, :diff=>1, :prev_diff=>1}}
  # expected: "-10--8,-6,-3-1,3-5,7-11,14,15,17-20"
  #      got: "-10--8,-6,-3-1,3-5,7-11,14-15,17-20"
  def solution(arr)
    diff_hash = diff_hasher(arr)
    build_str = ''
    prev_prev_diff = nil
    diff_hash.each do |k, v|
      build_str += v[:val].to_s if k == '0'
      build_str += '' if v[:diff] && v[:diff] == 1 && v[:prev_diff] && v[:prev_diff] == 1
      build_str += "-#{v[:prev_element]}" if v[:diff] && v[:diff] > 1 && v[:prev_diff] && v[:prev_diff] == 1 && prev_prev_diff == 1
      build_str += "-#{v[:val]}" if k.to_i == (arr.size-1) && v[:prev_diff] && v[:prev_diff] == 1
      build_str += ",#{v[:val]}" if v[:diff] && v[:diff] > 1
      prev_prev_diff = v[:prev_diff] if v[:prev_diff] && v[:prev_diff] == 1
      
    end
    build_str
  end

  def diff_hasher(arr)
    diff_h = {}
    prev_element = nil
    prev_diff = nil
    arr.each_with_index do |element, arr_index|
      diff_h[arr_index.to_s] = {}
      diff_h[arr_index.to_s][:val] = element
      if arr_index > 1
        diff_h[arr_index.to_s][:prev_element] = prev_element
        diff = element - prev_element.to_i
        diff_h[arr_index.to_s][:diff] = diff
        # byebug
        diff_h[arr_index.to_s][:prev_diff] = prev_diff
        prev_diff = diff
      elsif arr_index > 0
        diff_h[arr_index.to_s][:prev_element] = prev_element
        diff = element - prev_element.to_i
        diff_h[arr_index.to_s][:diff] = diff
        # byebug
        prev_diff = diff
      end
      prev_element = element
    end
    pp diff_h
  end
end
