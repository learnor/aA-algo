require_relative "heap"

class Array
  def heap_sort!
    count.times do |i|
      BinaryMinHeap.heapify_up(self, i, i)
    end

    1.upto(count) do |i|
      self[0], self[count - i] = self[count - i], self[0]
      BinaryMinHeap.heapify_down(self, 0, count - i)
    end

    self.reverse!
  end
end
