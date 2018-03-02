require 'byebug'
class QuickSort
  # Quick sort has average case time complexity O(nlogn), but worst
  # case O(n**2).

  # Not in-place. Uses O(n) memory.
  def self.sort1(array)
    return array if array.length < 2
    pivot = array[0]
    left = []
    right = []
    array[1..-1].each do |el|
      if el < pivot
        left << el
      else
        right << el
      end
    end
    sort1(left) + [pivot] + sort1[right]
  end

  # In-place.
  def self.sort2!(array, start = 0, length = array.length, &prc)
    return array if length < 2
    pivot_idx = partition(array, start, length, &prc)

    sort2!(array, start, pivot_idx - start, &prc)
    sort2!(array, pivot_idx + 1, length - pivot_idx - 1, &prc)
  end

  def self.partition(array, start, length, &prc)
    prc ||= Proc.new{ |x, y| x <=> y }
    p_idx = start
    1.upto(length - 1) do |i|
      current_idx = start + i
      if prc.call(array[current_idx], array[start], p_idx) == -1
        p_idx += 1
        array[p_idx], array[current_idx] = array[current_idx], array[p_idx] if p_idx < current_idx
      end
    end
    array[p_idx], array[start] = array[start], array[p_idx]
    p_idx
  end
end
