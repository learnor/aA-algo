require 'byebug'
class DynamicProgramming

  def initialize
    @blair_cache = { 1 => 1, 2 => 2 }
  end

  def blair_nums(n)
    @blair_cache[n] ||= blair_nums(n - 1) + blair_nums(n - 2) + ((n - 1) * 2 - 1)
  end

  def blair_nums_bottom_up(n)
    b_nums = { 1 => 1, 2 => 2 }
    3.upto(n) { |i| b_nums[i] = b_nums[i - 1] + b_nums[i - 2] + ((n - 1) * 2 - 1) }

    b_nums[n]
  end

  def frog_hops_bottom_up(n)
    frog_cache_builder(n)[n]
  end

  def frog_cache_builder(n)
    def hop_ways_builder(ways, num)
      ways.map { |e| e + [num] }
    end

    frog_cache = [[], [[1]], [[1, 1], [2]], [[1, 1, 1], [1, 2], [2, 1], [3]]]

    4.upto(n) do |i|
      frog_cache[i] = (hop_ways_builder(frog_cache[i - 1], 1) +
        hop_ways_builder(frog_cache[i - 2], 2) +
        hop_ways_builder(frog_cache[i - 3], 3))
    end
    frog_cache
  end

  def frog_hops_top_down(n)

  end

  def frog_hops_top_down_helper(n)

  end

  def super_frog_hops(n, k)

  end

  def knapsack(weights, values, capacity)

  end

  # Helper method for bottom-up implementation
  def knapsack_table(weights, values, capacity)

  end

  def maze_solver(maze, start_pos, end_pos)
  end
end
