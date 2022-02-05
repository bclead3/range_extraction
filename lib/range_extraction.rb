require 'byebug'

class RangeExtraction

  def solution(arr)
    diff_hash = diff_hasher(arr)
    build_str = ''
    diff_hash.each do |_k, v|
      if v[:d] && v[:d] == 1
        if v[:p_d] == 1
          if v[:p_p_d] == 1
            build_str += "-#{v[:v]}" if v[:f_d] && v[:f_d] > 1 || v[:f_d].nil?
          elsif v[:p_p_d] > 1
            build_str += "-#{v[:v]}" if v[:f_d] > 1
          else
            build_str += "-#{v[:v]}"
          end
        elsif v[:p_d] > 1
          build_str += ",#{v[:v]}" if v[:f_d].nil? || v[:f_d] > 1
        elsif v[:p_d].zero?
          build_str += ",#{v[:v]}" if v[:f_d] > 1
        end
      elsif v[:d] && v[:d] > 1
        build_str += ",#{v[:v]}"
      else
        build_str += v[:v].to_s
      end
    end
    build_str
  end

  def diff_hasher(arr)
    diff_h = {}
    prev_element = nil
    p_diff = nil
    p_p_d = nil
    arr.each_with_index do |element, arr_index|
      s_index = arr_index.to_s
      diff = element - prev_element.to_i

      diff_h[s_index] = {}
      diff_h[s_index][:v] = element
      diff_h[s_index][:f_d] = arr[arr_index+1] ? arr[arr_index+1] - element : nil
      diff_h[s_index][:d] = prev_element.nil? ? nil : diff
      diff_h[s_index][:p_d] = p_diff
      diff_h[s_index][:p_p_d] = p_p_d

      p_p_d = p_diff
      p_diff = diff
      prev_element = element
    end
    diff_h
  end
end
