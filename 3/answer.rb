require 'pry'
data = File.read('input')
rows = data.split("\n")

angles = [[1,1],[1,3],[1,5],[1,7],[2,1]]

results = []

angles.each do |angle|
  trees = 0
  down, right = *angle
  rows.each_slice(down).map(&:first).each_with_index do |row, idx|
    obstacles = row.chars.cycle

    (idx * right).times { obstacles.next }
    hit = obstacles.next
    if hit == '#'
      trees +=1
    end
  end

  results << trees
end

puts results # debug
puts results.inject(:*)
