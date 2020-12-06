require 'pry'
data = File.read('input')
rows = data.split("\n")

# BFFFBBFRRR: row 70, column 7, seat ID 567

def get_row(data)
  data.gsub('B', '1').gsub('F','0').to_i(2)
end

def get_col(data)
  data.gsub('R', '1').gsub('L','0').to_i(2)
end


seats = rows.map do |encoded|
  [
    get_row(encoded[0..6]),
    get_col(encoded[7..-1])
  ]
end

ids = seats.map { |row, col| row * 8 + col }
# part 1
# pp ids.max

# part 2
puts (100..700).find { |id| ids.include?(id-1) && !ids.include?(id) && ids.include?(id+1) }
