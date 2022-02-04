require 'byebug'

class RangeExtraction

  # {"0"=>{:v=>-10, :p=>nil, :nxt=>-9, :f_d=>1, :d=>nil, :p_d=>nil, :p_p_d=>nil, :t_c=>0},
  #  "1"=>{:v=>-9, :p=>-10, :nxt=>-8, :f_d=>1, :d=>1, :p_d=>-10, :p_p_d=>nil, :t_c=>1},
  #  "2"=>{:v=>-8, :p=>-9, :nxt=>-6, :f_d=>2, :d=>1, :p_d=>1, :p_p_d=>-10, :t_c=>2},
  #  "3"=>{:v=>-6, :p=>-8, :nxt=>-3, :f_d=>3, :d=>2, :p_d=>1, :p_p_d=>1, :t_c=>0},
  #  "4"=>{:v=>-3, :p=>-6, :nxt=>-2, :f_d=>1, :d=>3, :p_d=>2, :p_p_d=>1, :t_c=>0},
  #  "5"=>{:v=>-2, :p=>-3, :nxt=>-1, :f_d=>1, :d=>1, :p_d=>3, :p_p_d=>2, :t_c=>1},
  #  "6"=>{:v=>-1, :p=>-2, :nxt=>0, :f_d=>1, :d=>1, :p_d=>1, :p_p_d=>3, :t_c=>2},
  #  "7"=>{:v=>0, :p=>-1, :nxt=>1, :f_d=>1, :d=>1, :p_d=>1, :p_p_d=>1, :t_c=>3},
  #  "8"=>{:v=>1, :p=>0, :nxt=>3, :f_d=>2, :d=>1, :p_d=>1, :p_p_d=>1, :t_c=>4},
  #  "9"=>{:v=>3, :p=>1, :nxt=>4, :f_d=>1, :d=>2, :p_d=>1, :p_p_d=>1, :t_c=>0},
  #  "10"=>{:v=>4, :p=>3, :nxt=>5, :f_d=>1, :d=>1, :p_d=>2, :p_p_d=>1, :t_c=>1},
  #  "11"=>{:v=>5, :p=>4, :nxt=>7, :f_d=>2, :d=>1, :p_d=>1, :p_p_d=>2, :t_c=>2},
  #  "12"=>{:v=>7, :p=>5, :nxt=>8, :f_d=>1, :d=>2, :p_d=>1, :p_p_d=>1, :t_c=>0},
  #  "13"=>{:v=>8, :p=>7, :nxt=>9, :f_d=>1, :d=>1, :p_d=>2, :p_p_d=>1, :t_c=>1},
  #  "14"=>{:v=>9, :p=>8, :nxt=>10, :f_d=>1, :d=>1, :p_d=>1, :p_p_d=>2, :t_c=>2},
  #  "15"=>{:v=>10, :p=>9, :nxt=>11, :f_d=>1, :d=>1, :p_d=>1, :p_p_d=>1, :t_c=>3},
  #  "16"=>{:v=>11, :p=>10, :nxt=>14, :f_d=>3, :d=>1, :p_d=>1, :p_p_d=>1, :t_c=>4},
  #  "17"=>{:v=>14, :p=>11, :nxt=>15, :f_d=>1, :d=>3, :p_d=>1, :p_p_d=>1, :t_c=>0},
  #  "18"=>{:v=>15, :p=>14, :nxt=>17, :f_d=>2, :d=>1, :p_d=>3, :p_p_d=>1, :t_c=>1},
  #  "19"=>{:v=>17, :p=>15, :nxt=>nil, :f_d=>nil, :d=>2, :p_d=>1, :p_p_d=>3, :t_c=>0}}
  def solution(arr)
    diff_hash = diff_hasher(arr)
    build_str = ''
    prev_track_count = 0
    diff_hash.each do |k, v|
      build_str += v[:v].to_s if k == '0'
      if v[:d] &&
         v[:d] > 1 &&
         v[:p_d] &&
         v[:p_d] == 1 &&
         v[:p_p_d] == 1
        build_str += "-#{v[:p]}"
      end
      if k.to_i == (arr.size-1) &&
         v[:d] &&
         v[:d] == 1 &&
         v[:p_d] &&
         v[:p_d] == 1
        build_str += "-#{v[:v]}"
      end
      if k.to_i == (arr.size-1) &&
         v[:d] &&
         v[:d] == 1 &&
         v[:p_d] &&
         v[:p_d] > 1
        build_str += ",#{v[:v]}"
      end
      if v[:d] &&
         v[:d] == 1 &&
         v[:p_d] &&
         v[:p_d] > 1 &&
         v[:p_p_d] == 1 &&
         v[:t_c] > 1
        build_str += ",#{v[:v]}"
      end
      if v[:d] &&
         v[:d] > 1
        build_str += ",#{v[:v]}"
      end
      if v[:d] &&
         v[:d] == 1 &&
         v[:f_d] &&
         v[:f_d] > 1 &&
         v[:p_d] &&
         v[:p_d] > 1
        build_str += ",#{v[:v]}"
      end
    end
    build_str
  end

  def diff_hasher(arr)
    diff_h = {}
    prev_element = nil
    p_diff = nil
    p_p_d = nil
    track_count = 0
    arr.each_with_index do |element, arr_index|
      s_index = arr_index.to_s
      diff = element - prev_element.to_i

      diff_h[s_index] = {}
      diff_h[s_index][:v] = element
      diff_h[s_index][:p] = prev_element
      diff_h[s_index][:nxt] = arr[arr_index+1]
      diff_h[s_index][:f_d] = arr[arr_index+1] ? arr[arr_index+1] - element : nil
      diff_h[s_index][:d] = prev_element.nil? ? nil : diff
      diff_h[s_index][:p_d] = p_diff
      diff_h[s_index][:p_p_d] = p_p_d
      diff_h[s_index][:t_c] = diff == 1 ? track_count+=1 : track_count = 0

      p_p_d = p_diff
      p_diff = diff
      prev_element = element
    end
    diff_h
  end
end
