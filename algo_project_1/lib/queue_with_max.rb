# Implement a queue with #enqueue and #dequeue, as well as a #max API,
# a method which returns the maximum element still in the queue. This
# is trivial to do by spending O(n) time upon dequeuing.
# Can you do it in O(1) amortized? Maybe use an auxiliary storage structure?

# Use your RingBuffer to achieve optimal shifts! Write any additional
# methods you need.

require_relative 'ring_buffer'

class QueueWithMax
  attr_accessor :store, :max_arr

  def initialize
    @store = RingBuffer.new
    @max_arr = RingBuffer.new
  end

  def enqueue(val)
    @store.push(val)
    if @max_arr.length == 0
      @max_arr.push(val)
    else
      last_idx = @max_arr.length - 1
      if @max_arr[last_idx] < val
        (last_idx + 1).times { @max_arr.pop }
        @max_arr.push(val)
      elsif @max_arr[0] >= val
        @max_arr.unshift(val)
      else
        @max_arr[0] = val
      end
    end
    val
  end

  def dequeue
    raise "empty queue" unless @store.length > 0
    dequeued = @store.shift
    last_idx = @max_arr.length - 1
    if dequeued == @max_arr[last_idx]
      @max_arr.pop
    elsif dequeued == @max_arr[0]
      @max_arr.shift
    end
    dequeued
  end

  def max
    @max_arr.length > 0 ? @max_arr[@max_arr.length - 1] : nil
  end

  def length
    @store.length
  end

end
