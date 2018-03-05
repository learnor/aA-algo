require 'byebug'
require 'binary_search_tree'

def kth_largest(tree_node, k)
  bst_tree = BinarySearchTree.new
  bst_tree.root = tree_node
  # debugger
  (k - 1).times do
    bst_tree.delete(bst_tree.maximum.value)
  end
  bst_tree.maximum
end
