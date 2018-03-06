require_relative 'p05_hash_map'
require_relative 'p04_linked_list'

class LRUCache
  attr_reader :count
  def initialize(max, prc)
    @map = HashMap.new
    @store = LinkedList.new
    @max = max
    @prc = prc
  end

  def count
    @map.count
  end

  def get(key)
    node = @map[key]
    if node
      update_node!(node)
      node.val
    else
      calc!(key)
    end
  end

  def to_s
    "Map: " + @map.to_s + "\n" + "Store: " + @store.to_s
  end

  private

  def calc!(key)
    # suggested helper method; insert an (un-cached) key
    eject! if count == @max
    new_node = @store.append(key, @prc.call(key))
    @map[key] = new_node
    new_node.val
  end

  def update_node!(node)
    # suggested helper method; move a node to the end of the list
    node.remove
    @store.append(node.key, node.val)
  end

  def eject!
    first_node = @store.first
    first_node.remove
    @map.delete(first_node.key)
  end
end
