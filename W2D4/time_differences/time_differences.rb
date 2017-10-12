
def my_min_quadratic(list)
  list.each do |el|
    smallest = true
    list.each do |el2|
      if el2 < el
        smallest = false
      end
    end
    return el if smallest
  end
end

def my_min_linear(list)
  smallest = list.first
  list.each do |el|
    smallest = el if el < smallest
  end
  smallest
end

def sub_arrays(array)
  arrays = []
  array.each_index do |i|
    (i...array.length).each do |j|
      arrays << array[i..j]
    end
  end
  arrays
end

def largest_contiguous_subsum_quadratic(list)
  subs = sub_arrays(list)

  subs.reduce(subs.first.reduce(:+)) do |accum, sub_arr|
    value = sub_arr.reduce(:+)
    if value > accum
      value
    else
      accum
    end
  end
end

def largest_contiguous_subsum_linear(list)
  largest_sum = list[0]

  i = 0
  j = 1
  new_sum = list[0]

  while j < list.length
    new_sum += list[j]
    if new_sum > largest_sum
      largest_sum = new_sum
      j += 1
    elsif list[j] > new_sum
      new_sum = 0
      i = j
    elsif new_sum <= 0
      new_sum = 0
      i = j + 1
      j = i
    else
      j += 1
    end
  end
  largest_sum
end

puts largest_contiguous_subsum_linear([5, 3, -7])
puts largest_contiguous_subsum_linear([2, 3, -6, 7, -6, 7])
puts largest_contiguous_subsum_linear([-5, -1, -3])
puts largest_contiguous_subsum_linear([2, 3, -6, 7, -6])
puts largest_contiguous_subsum_linear([2, 3, 7, 5, -6, 9, 7, -6])
puts largest_contiguous_subsum_linear([-5, -6, 3, -1, 4, -3])
puts largest_contiguous_subsum_linear([999,-1000,1000,2000])
