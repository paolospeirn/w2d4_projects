require 'byebug'

def first_anagram?(string1, string2)
  string_arr1 = string1.split("")

  # O(n)
  permutations(string_arr1).include?(string2.split(""))
end

  # O(n!)
def permutations(string_arr)
  return [string_arr] if string_arr.length <= 1

  first = string_arr.shift
  perms = permutations(string_arr)
  all_perms = []

  perms.each do |perm|
    (0..perm.length).each do |idx|
      all_perms << perm[0 ... idx] + [first] + perm[idx .. -1]
    end
  end

  all_perms
end

# O(n**2) because each loop checks the entire inside of the string. quite bad
def second_anagram?(string1, string2)
  string1_arr = string1.split("")
  string2_arr = string2.split("")
  str_1 = string1_arr.dup

  string1_arr.each do |ch|
    if string2_arr.include?(ch)
      delete_idx = string2_arr.index(ch)
      string2_arr.delete_at(delete_idx)
      str_1.shift
    end
  end

  str_1.empty? && string2_arr.empty?
end

# n log(n) because the n of == is crushed
def third_anagram?(string1, string2)
  string1.chars.sort == string2.chars.sort
end

# O(3n) ie O(n)
def fourth_anagram?(string1, string2)
  str1_hash = Hash.new(0)
  str2_hash = Hash.new(0)

  string1.each_char do |ch|
    str1_hash[ch] += 1
  end

  string2.each_char do |ch|
    str2_hash[ch] += 1
  end

  str1_hash.each do |k, v|
    return false unless str2_hash[k] == v
  end

  true
end


if __FILE__ == $PROGRAM_NAME

test_anagram = first_anagram?('elvis', 'lives')
p test_anagram

elvis = second_anagram?("elvis", "lives")
puts elvis

elvis2 = third_anagram?("elvis", "lives")
puts elvis2

elvis3 = fourth_anagram?("elvis", "lives")
puts elvis3
end
