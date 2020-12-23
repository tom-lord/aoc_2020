require 'pry'
data = File.read('input')
seats = data.split("\n").map {|r| r.split('')}

# L - Empty
# # - Taken
# . - Floor

# PART 1:

# def adjacent_seats(seats, row_idx, col_idx)
#   [
#     [row_idx - 1, col_idx - 1],
#     [row_idx - 1, col_idx],
#     [row_idx - 1, col_idx + 1],
#     [row_idx, col_idx - 1],
#     [row_idx, col_idx + 1],
#     [row_idx + 1, col_idx - 1],
#     [row_idx + 1, col_idx],
#     [row_idx + 1, col_idx + 1]
#   ].select do |r, c|
#     # eliminate anything off the grid
#     r >= 0 && r < seats.count && c >= 0 && c < seats.first.count
#   end.map do |r, c|
#     seats[r][c]
#   end
# end
#
# (1..).each do |i|
#   puts "Round #{i}:"
#
#   new_seats = seats.map.with_index do |row, row_idx|
#     row.map.with_index do |seat, col_idx|
#       case seat
#       when 'L'
#         # If there are NO occupied seats adjacent to it, the seat becomes occupied.
#         if adjacent_seats(seats, row_idx, col_idx).none? { |a| a == '#'}
#           '#'
#         else
#           'L'
#         end
#       when '#'
#         # If there are FOUR occupied seats adjacent to it, the seat becomes empty.
#         if adjacent_seats(seats, row_idx, col_idx).count { |a| a == '#'} >= 4
#           'L'
#         else
#           '#'
#         end
#       when '.'
#         '.' # Never changes
#       else
#         raise "Unknown seat type: #{seat}"
#       end
#     end
#   end
#   puts new_seats.map { |row| row.join('') }.join("\n")
#
#   if seats == new_seats
#     break
#   else
#     seats = new_seats
#   end
# end

# How many seats end up occupied?
# puts "Answer: #{seats.flatten.count { |x| x == '#' }}"

# PART 2:

# TODO: Generalise this to scan in 8 directions for 'L' and '#'
# Then count the number of '#'s
def occupied_seat_in_direction?(seats, curr_seat:, direction:)
  (1..).each do |distance|
    test_coordinates = [
      curr_seat[0] + direction[0] * distance,
      curr_seat[1] + direction[1] * distance
    ]
    # TODO: This can be simplified by checking for floor ('.') instead
    # we're off the grid to the top/left!
    return false if test_coordinates[0] < 0 || test_coordinates[1] < 0
    # we're off the grid to the bottom/right!
    return false if seats.dig(test_coordinates[0], test_coordinates[1]).nil?
    # I spy an empty seat! :eyes:
    return false if seats.dig(test_coordinates[0], test_coordinates[1]) == 'L'
    # I spy an occupied seat! :eyes:
    return true if seats.dig(test_coordinates[0], test_coordinates[1]) == '#'
  end
end

def directional_occupied_seats(seats, row_idx, col_idx)
  #binding.pry if row_idx == 0 && col_idx == 3
  # list of directions, e.g. [-1, 1] means "north east"
  [
    [-1, -1],
    [-1, 0],
    [-1, 1],
    [0, -1],
    [0, 1],
    [1, -1],
    [1, 0],
    [1, 1]
  ].count do |direction|
    occupied_seat_in_direction?(seats, curr_seat: [row_idx, col_idx], direction: direction)
  end
end

(1..).each do |i|
  puts "Round #{i}:"

  new_seats = seats.map.with_index do |row, row_idx|
    row.map.with_index do |seat, col_idx|
      case seat
      when 'L'
        # If there are NO occupied seats directional to it, the seat becomes occupied.
        if directional_occupied_seats(seats, row_idx, col_idx) == 0
          '#'
        else
          'L'
        end
      when '#'
        # If there are FIVE occupied seats directional to it, the seat becomes empty.
        if directional_occupied_seats(seats, row_idx, col_idx) >= 5
          'L'
        else
          '#'
        end
      when '.'
        '.' # Never changes
      else
        raise "Unknown seat type: #{seat}"
      end
    end
  end
  puts new_seats.map { |row| row.join('') }.join("\n")

  if seats == new_seats
    break
  else
    seats = new_seats
  end
end

# How many seats end up occupied?
# 143 is too low
puts "Answer: #{seats.flatten.count { |x| x == '#' }}"
