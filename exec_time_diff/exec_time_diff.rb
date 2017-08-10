require 'byebug'

# O(n^2) because of nesting
def my_min(list)
  smallest = list.first
  list.each do |el|
    list.each do |el2|
      smallest = el2 if el2 < smallest
    end
  end
  puts "Found #{smallest} in O(n^2) time"
end

# O(n) because we only make comparisons proportional to input size.
def better_my_min(list)
  smallest = list.first
  list.each do |el|
    smallest = el if el < smallest
  end
  puts "Found #{smallest} in O(n) time"
end

# O(n**2) because each additional element increases the
def largest_contig_sum(list)
  maxes = []

  (0 ... list.length).each do |i1|
    (i1 ... list.length).each do |i2|
      maxes << list[i1..i2].reduce(&:+)
    end
  end
  puts "Found #{maxes.max} in O(n**2)?"
  maxes.max
end

def better_contig_sum(list)
  biggest = 0

  list.each_with_index do |el, idx|
    follower_sum = list[0 ... idx].reduce(:+)
    leader_sum = list[idx .. -1].reduce(:+)
    case follower_sum <=> leader_sum
    when 0 || -1
      biggest = leader_sum if leader_sum > biggest
    when 1
      biggest = follower_sum if follower_sum > biggest
    end
  end
  puts "Found #{biggest} in O(n) time with O(1) memory."
end


def best_contig_sum(list)
  biggest = 0
  current_sum = 0

  debugger
  list.each_with_index do |el, idx|
    current_sum += el
    biggest = current_sum if current_sum > biggest
    if current_sum < 0
      current_sum = 0
    end
  end
  biggest
end

if __FILE__ == $PROGRAM_NAME

  LIST = [ 0, 3, 5, 4, -5, 10, 1, 90 ]

  my_min(LIST)

  better_my_min(LIST)

  largest_contig_sum([5,3,-7])

  better_contig_sum([5,3,-7])

  best_contig_sum([2,3,-6,7,-6,7])

end
