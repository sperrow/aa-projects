require_relative 'data_types'
require 'benchmark'
def windowed_max_range(arr, w)
  current_max_range = nil
  arr.each_index do |i|
    break if i + w > arr.length
    window = arr[i...i + w]
    max = window.max
    min = window.min
    if current_max_range.nil? || max - min > current_max_range
      current_max_range = max - min
    end
  end
  current_max_range
end

# puts windowed_max_range([1, 0, 2, 5, 4, 8], 2) == 4 # 4, 8
# puts windowed_max_range([1, 0, 2, 5, 4, 8], 3) == 5 # 0, 2, 5
# puts windowed_max_range([1, 0, 2, 5, 4, 8], 4) == 6 # 2, 5, 4, 8
# puts windowed_max_range([1, 3, 2, 5, 4, 8], 5) == 6 # 3, 2, 5, 4, 8

def windowed_max_range_optimized(arr, w)
  queue = StackQueue.new
  i = 0
  w.times do
    queue.enqueue(arr[i])
    i += 1
  end
  current_max_range = queue.max - queue.min
  until i == arr.length
    queue.dequeue
    queue.enqueue(arr[i])
    new_range = queue.max - queue.min
    current_max_range = new_range if new_range > current_max_range
    i += 1
  end
  current_max_range
end

puts windowed_max_range_optimized([1, 0, 2, 5, 4, 8], 2) # 4, 8
puts windowed_max_range_optimized([1, 0, 2, 5, 4, 8], 3) # 0, 2, 5
puts windowed_max_range_optimized([1, 0, 2, 5, 4, 8], 4) # 2, 5, 4, 8
puts windowed_max_range_optimized([1, 3, 2, 5, 4, 8], 5) # 3, 2, 5, 4, 8
a = (1..100000).to_a

be = []
Benchmark.bm do |b|
  b.report("optimized") { windowed_max_range_optimized(a, 2000)}
  b.report { windowed_max_range(a, 2000) }
end
