require 'pry'
data = File.read('input')
rows = data.split("\n\n")

fields = %w[byr iyr eyr hgt hcl ecl pid cid]
# byr (Birth Year) - four digits; at least 1920 and at most 2002.
# iyr (Issue Year) - four digits; at least 2010 and at most 2020.
# eyr (Expiration Year) - four digits; at least 2020 and at most 2030.
# hgt (Height) - a number followed by either cm or in:
# If cm, the number must be at least 150 and at most 193.
# If in, the number must be at least 59 and at most 76.
# hcl (Hair Color) - a # followed by exactly six characters 0-9 or a-f.
# ecl (Eye Color) - exactly one of: amb blu brn gry grn hzl oth.
# pid (Passport ID) - a nine-digit number, including leading zeroes.
# cid (Country ID) - ignored, missing or not.

result = rows.count do |row|
  entries = row.split(/\s/)
  entry_fields = entries.map {|entry| entry.split(':').first}

  next unless (fields - ['cid']).all? { |x| entry_fields.include?(x) }

  entries.all? do |entry|
    name, value = entry.split(':')
    case name
    when 'byr'
      #(Birth Year) - four digits; at least 1920 and at most 2002.
      value =~ /^\d{4}$/ && value.to_i.between?(1920, 2002)
    when 'iyr'
      #(Issue Year) - four digits; at least 2010 and at most 2020.
      value =~ /^\d{4}$/ && value.to_i.between?(2010, 2020)
    when 'eyr'
      #(Expiration Year) - four digits; at least 2020 and at most 2030.
      value =~ /^\d{4}$/ && value.to_i.between?(2020, 2030)
    when 'hgt'
      #(Height) - a number followed by either cm or in:
      #'If cm, the number must be at least 150 and at most 193.
      #'If in, the number must be at least 59 and at most 76.
      (value =~ /^\d{3}cm$/ && value.to_i.between?(150,193)) ||
        (value =~ /^\d{2}in$/ && value.to_i.between?(59,76))
    when 'hcl'
      #(Hair Color) - a # followed by exactly six characters 0-9 or a-f.
      value =~ /^#\h{6}$/
    when 'ecl'
      #(Eye Color) - exactly one of: amb blu brn gry grn hzl oth.
      value =~ /^(amb|blu|brn|gry|grn|hzl|oth)$/
    when 'pid'
      #(Passport ID) - a nine-digit number, including leading zeroes.
      value =~ /^\d{9}$/
    when 'cid'
      #(Country ID) - ignored, missing or not.
      true
    else
      raise name
    end
  end
end

puts result
