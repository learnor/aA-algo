require 'byebug'
class BinaryMinHeap
  attr_reader :store, :prc

  def initialize(&prc)
    @store = []
    @prc = prc
  end

  def count
    @store.length
  end

  def extract
    @store[0], @store[-1] = @store[-1], @store[0]
    extracted = @store.pop
    self.class.heapify_down(@store, 0, &@prc)
    extracted
  end

  def peek
    @store[0]
  end

  def push(val)
    @store.push(val)
    self.class.heapify_up(@store, count - 1, &@prc)
  end

  public
  def self.child_indices(len, parent_index)
    [parent_index * 2 + 1, parent_index * 2 + 2].select { |i| i < len }
  end

  def self.parent_index(child_index)
    raise "root has no parent" if child_index == 0
    (child_index - 1) / 2
  end

  def self.heapify_down(array, parent_idx, len = array.length, &prc)
    prc ||= Proc.new { |x, y| x <=> y }
    until child_indices(len, parent_idx).empty?
      child_idxs = child_indices(len, parent_idx)
      if child_idxs.length == 2
        child_idx = prc.call(array[child_idxs[0]], array[child_idxs[1]]) < 0 ? child_idxs[0] : child_idxs[1]
      else
        child_idx = child_idxs[0]
      end
      if prc.call(array[parent_idx], array[child_idx]) > 0
        array[parent_idx], array[child_idx] =
        array[child_idx], array[parent_idx]
      else
        break
      end
      parent_idx = child_idx
    end
    array
  end

  def self.heapify_up(array, child_idx, len = array.length, &prc)
    prc ||= Proc.new { |x, y| x <=> y }
    until child_idx == 0
      parent_idx = parent_index(child_idx)
      if prc.call(array[parent_idx], array[child_idx]) > 0
        array[parent_idx], array[child_idx] =
          array[child_idx], array[parent_idx]
      else
        break
      end
      child_idx = parent_idx
    end
    array
  end
end
