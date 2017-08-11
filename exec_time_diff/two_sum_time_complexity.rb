require "byebug"

#0(n**2) due to nested loops
def bad_two_sum?(array, target)
  result = []
  array.each_with_index do |el, i|
    array.each_with_index do |el2, i2|
      next if i >= i2
      result << [i, i2] if el + el2 == target
    end
  end
  return true unless result.empty?
end


# O(n log n) n = loop to search array, log n for binary search
def okay_two_sum?(array, target)
  sorted_arr = array.sort

  sorted_arr.each do |el|
    partner = target - el
    partner_idx = binary_search(sorted_arr, partner)
    return true if partner_idx
  end

  false
end

def binary_search(array, target)
  prc = Proc.new { |v1, v2| v1 <=> v2 }

  return nil if array.empty?
  return array if array.length == 1

  mid = array.length / 2
  mid_val = array[mid]
  return mid if mid_val == target

  left = array[0 ... mid]
  right = array[mid + 1 .. -1]

  case prc.call(target, mid_val)
  when 1
    rsearch = binary_search(right, target)
    rsearch.nil? ? nil : mid + 1 + rsearch
  else
    binary_search(left, target)
  end

end

#O(n) because we just iterate twice
def hash_two_sum?(array, target)

  hash = Hash.new
  array.each_with_index do |el, i|
    hash[el] = i
  end

  hash.keys.each do |k|
    partner = target - k
    return true if hash[partner]
  end

end


if __FILE__ == $PROGRAM_NAME
  array = [1, 1, 5, 7]
  target = 6
  bad = bad_two_sum?(array, target)
  puts bad

  okay = okay_two_sum?(array, target)
  puts okay

  sample = hash_two_sum?(array, target)
  puts sample

end
