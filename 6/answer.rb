require 'pry'
data = File.read('input')

require 'set'
rows = data.split("\n\n")

# part 1
# counts = rows.map do |row|
#   Set.new(row.delete("\n").split('')).count
# end
# puts counts.sum


# part 2
counts = rows.map do |row|
  answers = row.split("\n").map { |answer| answer.split('') }
  answers.inject(:&).count
end
puts counts.sum
