data = File.read('input')
numbers = data.split("\n").map(&:to_i)

answer = numbers.find { |x| numbers.include?(2020 - x) }

puts "PART 1:"
puts answer * (2020 - answer)


num1 = nil
num2 = nil
num1 = numbers.find do |x|
  target = 2020 - x

  num2 = numbers.find { |x| numbers.include?(target - x) }
end

puts "PART 2:"
puts num1 * num2 * (2020 - num1 - num2)
