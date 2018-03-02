require_relative 'heap'

def k_largest_elements(array, k)
  k_heap = BinaryMinHeap.new
  k.times { k_heap.push(array.pop) }

  until array.empty?
    k_heap.push(array.pop)
    k_heap.extract
  end
  k_heap.store
end
