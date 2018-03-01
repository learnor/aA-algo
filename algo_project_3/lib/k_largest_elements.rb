require_relative 'heap'

def k_largest_elements(array, k)
  len = array.length
  len.times do |i|
    BinaryMinHeap.heapify_up(array, i, i) { |x, y| -1 * (x <=> y) }
  end

  k_arr = []
  k.times do
    array[0], array[-1] = array[-1], array[0]
    k_arr << array.pop
    BinaryMinHeap.heapify_down(array, 0) { |x, y| -1 * (x <=> y) }
  end
  k_arr
end
