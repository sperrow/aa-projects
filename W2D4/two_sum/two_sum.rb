
def bad_two_sum?(arr, target)
  arr.each_index do |i|
    (i+1...arr.length).each do |j|
      return true if arr[i] + arr[j] == target
    end
  end
  false
end

arr = [0, 1, 5, 7]
puts bad_two_sum?(arr, 6) # => should be true
puts bad_two_sum?(arr, 10)

def okay_two_sum?(arr, target)
  sorted = arr.sort
  sorted.each_with_index do |num, i|
    result = binary_search(sorted,(target - num))
    return true if !result.nil? && result != i
  end
  return false
end

# def binary_search(arr, target)
#   return nil if arr.empty?
#   puts arr.to_s
#   half = arr.length/2
#   val = arr[half]
#   if val == target
#     return half
#   elsif val > target
#     binary_search(arr[0...half], target)
#   else
#     result = binary_search(arr.drop(half+1), target)
#     return nil unless result
#     half + result
#   end
# end

def binary_search(array, value, from=0, to=nil)
  if to == nil
      to = array.count - 1
  end
  return nil if from > to
  mid = (from + to) / 2

  if value < array[mid]
      return binary_search array, value, from, mid - 1
  elsif value > array[mid]
      return binary_search array, value, mid + 1, to
  else
      return mid
  end
end

arr = [-1,2,7,5,7,8,9]
arr.sort!
#
puts okay_two_sum?(arr, 13) # => should be true
puts okay_two_sum?(arr, 14)

def good_two_sum?(arr, target)
  hash = Hash.new(0)
  arr.each do |el|
    hash[el] += 1
  end

  arr.each do |el|
    target_hash = target - el
    if el == target_hash
      return true if hash[target_hash] == 2
    else
      return true if hash[target_hash] == 1
    end
  end
  false
end

puts good_two_sum?(arr, 13) # => should be true
puts good_two_sum?(arr, 14123)
