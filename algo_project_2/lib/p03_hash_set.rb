require_relative 'p02_hashing'

class HashSet
  attr_reader :count

  def initialize(num_buckets = 8)
    @store = Array.new(num_buckets) { Array.new }
    @count = 0
  end

  def insert(key)
    # hashed = key.hash
    unless self.include?(key)
      resize! if @count == num_buckets
      self[key].push(key)
      @count += 1
    end
  end

  def include?(key)
    # hashed = key.hash
    self[key].include?(key)
  end

  def remove(key)
    # hashed = key.hash
    if self.include?(key)
      self[key].delete(key)
      @count -= 1
    end
  end

  private

  def [](num)
    # optional but useful; return the bucket corresponding to `num`
    num = num.hash
    @store[num % num_buckets]
  end

  def num_buckets
    @store.length
  end

  def resize!
    new_num_buckets = num_buckets * 2
    new_store = Array.new(new_num_buckets) { Array.new }
    @store.each do |bucket|
      bucket.each do |num|
        new_store[num % new_num_buckets].push(num)
      end
    end
    @store = new_store
  end
end
