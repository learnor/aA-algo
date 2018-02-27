require_relative "static_array"

class RingBuffer
  attr_reader :length

  def initialize
    @capacity = 8
    @length = 0
    @start_idx = 0
    @store = StaticArray.new(@capacity)
  end

  # O(1)
  def [](index)
    check_index(@start_idx + index)

    @store[@start_idx + index]
  end

  # O(1)
  def []=(index, val)
    @store[@start_idx + index] = val
  end

  # O(1)
  def pop
    check_index(@start_idx + @length - 1)

    @length -= 1
    @store[@start_idx + @length]
  end

  # O(1) ammortized
  def push(val)
    resize! unless @length < @capacity

    @store[@start_idx + @length] = val
    @length += 1
  end

  # O(1)
  def shift
    check_index(@start_idx)

    shifted = @store[@start_idx]
    @start_idx += 1
    @length -= 1
    shifted
  end

  # O(1) ammortized
  def unshift(val)
    resize! unless @length < @capacity
    
    @start_idx -= 1
    @store[@start_idx] = val
    @length += 1
  end

  protected
  attr_accessor :capacity, :start_idx, :store
  attr_writer :length

  def check_index(index)
    raise "index out of bounds" if index >= @start_idx + @length || index < @start_idx
  end

  def resize!
    @capacity *= 2
    new_store = StaticArray.new(@capacity)
    @length.times { |i| new_store[@start_idx + i] = @store[@start_idx + i] }
    @store = new_store
  end
end
