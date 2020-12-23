data = File.read('input')
rows = data.split("\n").map(&:to_i)

# PART 1:
# def valid_number?(new_number, preamble)
#   preamble.combination(2).any? { |combination| combination.sum == new_number }
# end
#
# result = rows[25..-1].find.with_index do |new_number, idx|
#   preamble = rows[idx..idx+25]
#   !valid_number?(new_number, preamble)
# end
#
# puts result

part1 = 776203571 # based on my input!

# Too low:
# 75220633
rows.each_with_index do |start_number, index|
  total = start_number
  numbers_summed = 0
  while total < part1
    numbers_summed += 1
    total += rows[index + numbers_summed]
  end
  if total == part1
    range = rows[index.. index+numbers_summed]
    puts "Result: #{range} --- #{range.min + range.max}"
    exit(0)
  end
end
