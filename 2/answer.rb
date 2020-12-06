data = File.read('input')
rows = data.split("\n")

valid = 0

rows.each do |row|
  repeats, letter, password = row.split(' ')

  repeats_min = repeats.split('-').first.to_i
  repeats_max = repeats.split('-').last.to_i
  letter = letter[0]

  if password.count(letter).between?(repeats_min, repeats_max)
    valid += 1
  end
end

puts valid



valid = 0
rows.each do |row|
  repeats, letter, password = row.split(' ')

  repeats_min = repeats.split('-').first.to_i
  repeats_max = repeats.split('-').last.to_i
  letter = letter[0]

  if (password[repeats_min-1] == letter) ^ (password[repeats_max-1] == letter)
    valid += 1
  end
end

puts valid
