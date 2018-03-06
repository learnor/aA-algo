# Given an Array of tuples, where tuple[0] represents a package id,
# and tuple[1] represents its dependency, determine the order in which
# the packages should be installed. Only packages that have dependencies
# will be listed, but all packages from 1..max_id exist.

# N.B. this is how `npm` works.

# Import any files you need to
require 'graph'
require 'topological_sort'

def install_order(arr)
  max_id = arr.reduce(&:+).max
  vertices = (1..max_id).to_a.map { |e| Vertex.new(e) }
  arr.each do |tuple|
    Edge.new(vertices[tuple[1] - 1], vertices[tuple[0] - 1])
  end
  # p topological_sort(vertices.values).map(&:value)
  topological_sort(vertices).map(&:value)
end
