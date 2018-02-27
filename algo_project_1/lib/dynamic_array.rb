require_relative "static_array"

class DynamicArray
  attr_reader :length

  def initialize
    @capacity = 8
    @length = 0
    @store = StaticArray.new(@capacity)
  end

  # O(1)
  def [](index)
    raise "index out of bounds" unless @store[index]
    @store[index]
  end

  # O(1)
  def []=(index, value)
    @store[index] = value
  end

  # O(1)
  def pop
    if @length > 0
      @length -= 1
      @store[@length]
    else
      raise "index out of bounds"
    end
  end

  # O(1) ammortized; O(n) worst case. Variable because of the possible
  # resize.
  def push(val)
    resize! unless @length < @capacity
    @store[@length] = val
    @length += 1
  end

  # O(n): has to shift over all the elements.
  def shift
    if @length > 0
      @length -= 1
      shifted = @store[0]
      @length.times { |i| @store[i] = @store[i + 1] }
      shifted
    else
      raise "index out of bounds"
    end
  end

  # O(n): has to shift over all the elements.
  def unshift(val)
    resize! unless @length < @capacity
    @length.downto(1) { |i| @store[i] = @store[i - 1] }
    @store[0] = val
    @length += 1
  end

  protected
  attr_accessor :capacity, :store
  attr_writer :length

  def check_index(index)
  end

  # O(n): has to copy over all the elements to the new store.
  def resize!
    @capacity *= 2
    new_store = StaticArray.new(@capacity)
    @length.times { |i| new_store[i] = @store[i] }
    @store = new_store
  end
end
