# require 'byebug'
require 'bst_node.rb'
# There are many ways to implement these methods, feel free to add arguments
# to methods as you see fit, or to create helper methods.

class BinarySearchTree
  attr_accessor :root

  def initialize
    @root = nil
  end

  def insert(value)
    return @root = BSTNode.new(value) if @root.nil?
    node_insert(@root, value)
  end

  def find(value, tree_node = @root)
    return nil if tree_node.nil?
    case (tree_node.value <=> value)
    when 0
      return tree_node
    when 1
      return find(value, tree_node.left)
    when -1
      return find(value, tree_node.right)
    end
  end

  def delete(value)
    node = find(value)
    # node has no children, simply remove it
    if node.left.nil? && node.right.nil?
      return @root = nil if @root == node
      if value > node.parent.value
        node.parent.right = nil
      else
        node.parent.left = nil
      end
    # node has two children
    elsif node.left && node.right
      # find the largest node in its left subtree
      max_child_node = maximum(node.left)
      # promote that node to replace deleted node
      if node.value > node.parent.value
        node.parent.right = max_child_node
      else
        node.parent.left = max_child_node
      end
      # when necessary, promote that node's child to replace its parent
      if max_child_node.left
        if max_child_node.value > max_child_node.parent.value
          max_child_node.parent.right = max_child_node.left
        else
          max_child_node.parent.left = max_child_node.left
        end
      end
      # if a node has only one child, delete it and promote its child to take its place.
    elsif node.left
      if @root = node
        @root = node.left
      elsif node.value > node.parent.value
        node.parent.right = node.left
      elsif node.value < node.parent.value
        node.parent.left = node.left
      end
    else
      if @root = node
        @root = node.right
      elsif node.value > node.parent.value
        node.parent.right = node.right
      elsif node.value < node.parent.value
        node.parent.left = node.right
      end
    end
  end

  # helper method for #delete:
  def maximum(tree_node = @root)
    return tree_node unless tree_node.right
    maximum(tree_node.right)
  end

  def depth(tree_node = @root)
    return 0 if tree_node.nil?
    return 0 unless tree_node.left || tree_node.right
    left =  depth(tree_node.left)
    right = depth(tree_node.right)
    [left, right].max + 1
  end

  def is_balanced?(tree_node = @root)
    return true if tree_node.nil?
    [-1, 0, 1].include?(depth(tree_node.left) - depth(tree_node.right)) && is_balanced?(tree_node.left) && is_balanced?(tree_node.right)

  end

  def in_order_traversal(tree_node = @root, arr = [])
    in_order_traversal(tree_node.left, arr) if tree_node.left
    arr << tree_node.value
    in_order_traversal(tree_node.right, arr) if tree_node.right
    arr
  end


  private
  # optional helper methods go here:
  def node_insert(node, value)
    if value < node.value
      if node.left
        node_insert(node.left, value)
      else
        node.left = BSTNode.new(value, node)
      end
    else
      if node.right
        node_insert(node.right, value)
      else
        node.right = BSTNode.new(value, node)
      end
    end
  end

end
