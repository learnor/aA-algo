require 'byebug'
require_relative 'graph'

# Implementing topological sort using both Khan's and Tarian's algorithms

def topological_sort(vertices)
  sorted = []
  queue = []
  vertices.each do |v|
    queue << v if v.in_edges.empty?
  end
  until queue.empty?
    u = queue.shift
    until u.out_edges.empty?
      e = u.out_edges.pop
      v = e.to_vertex
      e.destroy!
      queue << v if v.in_edges.empty?
    end
    # u.out_edges.each do |e|
    #   v = e.to_vertex
    #   e.destroy!
    #   queue << v if v.in_edges.empty?
    # end
    sorted << u
    # debugger
  end
  vertices.all? { |v| v.in_edges.empty? } ? sorted : []
end
