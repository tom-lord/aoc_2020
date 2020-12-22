data = File.read('input')
rows = data.split("\n").map { |row| [row.split(' ').first, row.split(' ').last.to_i] }

# PART 1:

# accumulator = 0
# index = 0
# seen_indexes = []
#
# while !seen_indexes.include?(index) do
#   seen_indexes << index
#   command = rows[index]
#
#   case command[0]
#   when 'acc'
#     puts "**DEBUG: #{command}, accumulator = #{accumulator}"
#     accumulator += command[1]
#     index += 1
#   when 'nop'
#     puts "**DEBUG: #{command}, accumulator = #{accumulator}"
#     index += 1
#   when 'jmp'
#     puts "**DEBUG: #{command}, accumulator = #{accumulator}"
#     index += command[1]
#   else
#     raise "Unknown command #{command[0]}"
#   end
# end

# PART 2:

# puts "Target: #{rows.count}"

target_index = 626

accumulator = 0
index = 0
seen_indexes = []

test_running = false
tried_indexes = []


loop do
  while !seen_indexes.include?(index) && index != target_index do
    seen_indexes << index
    command = rows[index]

    case command[0]
    when 'acc'
      puts "**DEBUG: #{command}, accumulator = #{accumulator}"
      accumulator += command[1]
      index += 1
    when 'nop'
      if !test_running && !tried_indexes.include?(index)
        tried_indexes << index
        test_running = true
        puts "***** Running test on #{command} (Index #{index}, already tried #{tried_indexes})"
        index += command[1]
      else
        puts "**DEBUG: #{command}, accumulator = #{accumulator}"
        index += 1
      end
    when 'jmp'
      if !test_running && !tried_indexes.include?(index)
        tried_indexes << index
        test_running = true
        puts "***** Running test on #{command} (Index #{index}, already tried #{tried_indexes})"
        index += 1
      else
        puts "**DEBUG: #{command}, accumulator = #{accumulator}"
        index += command[1]
      end
    else
      raise "Unknown command #{command[0]}"
    end
  end

  if index == target_index
    puts "Answer: #{accumulator}"
    exit(0)
  else
    accumulator = 0
    index = 0
    seen_indexes = []
    test_running = false # try again with another test
  end
end
