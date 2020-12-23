require 'pry'
data = File.read('input')
numbers = data.split("\n").map(&:to_i)

numbers << 0 # for the first
numbers << numbers.max + 3 # for the last
numbers.sort!

# PART 1:
# diffs = Hash.new(0)
# numbers.each_cons(2) do |num1, num2|
#   diffs[num2 - num1] += 1
# end
# puts diffs[1] * diffs[3]

# PART 2:
# The plan:
# Count consecutive runs of 1.
# For each block, count number of possible variants
# Multiply them together
# I figured these out with a bit of paper :)
block_size_to_variants = {
  1 => 1,
  2 => 2,
  3 => 4,
  4 => 7
}


diffs = numbers.each_cons(2).map do |num1, num2|
  num2 - num1
end
one_block_sizes = diffs.chunk(&:itself).select { |chunk| chunk[0] == 1 }.map { |chunk| chunk[1].count }
# For my data, that's:
# => [2, 1, 4, 2, 4, 1, 2, 1, 4, 4, 4, 4, 4, 3, 2, 4, 4, 4, 2, 4, 4, 4]

answer = one_block_sizes.map { |block_size| block_size_to_variants[block_size] }.inject(:*)

puts answer
