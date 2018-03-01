require_relative 'heap'

def k_largest_elements(array, k)
  heap = BinaryMinHeap.new { |x, y| -1 * (x <=> y) }
  array.each do |el|
    heap.push(el)
  end
  k_arr = []
  k.times do
    k_arr << heap.extract
  end
  k_arr
end
