class Node
  attr_accessor :key, :val, :next, :prev

  def initialize(key = nil, val = nil)
    @key = key
    @val = val
    @next = nil
    @prev = nil
  end

  def to_s
    "#{@key}: #{@val}"
  end

  def remove
    # optional but useful, connects previous node to next node
    # and removes self from list.
    self.next.prev = self.prev
    self.prev.next = self.next
    self.next = nil
    self.prev = nil
  end
end

class LinkedList
  include Enumerable

  def initialize
    @head = Node.new
    @tail = Node.new
    @head.next = @tail
    @tail.prev = @head
  end

  def [](i)
    each_with_index { |node, j| return node if i == j }
    nil
  end

  def first
    @head.next
  end

  def last
    @tail.prev
  end

  def empty?
    @head.next.key.nil?
  end

  def get(key)
    # return nil unless self.include?(key)
    node = first
    while node.val
      return node.val if node.key == key
      node = node.next
    end
    nil
  end

  def include?(key)
    !get(key).nil?
  end

  def append(key, val)
    node = Node.new(key, val)
    node.prev = @tail.prev
    node.prev.next = node
    node.next = @tail
    node.next.prev = node
  end

  def update(key, val)
    node = first
    while node.val
      return node.val = val if node.key == key
      node = node.next
    end
  end

  def remove(key)
    node = first
    while node.val
      if node.key == key
        node.remove
        return
      end
      node = node.next
    end
  end

  def each
    node = first
    while node.val
      yield(node)
      node = node.next
    end
  end

  # uncomment when you have `each` working and `Enumerable` included
  def to_s
    inject([]) { |acc, node| acc << "[#{node.key}, #{node.val}]" }.join(", ")
  end
end
