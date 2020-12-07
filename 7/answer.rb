require 'pry'
data = File.read('input')

rows = data.split("\n")

class Bag
  attr_reader :colour, :child_bags
  def initialize(colour, *child_bags)
    @colour = colour
    # An array of [count, 'other-colour']
    # Would be nicer to build proper nodes, but I'm lazy
    @child_bags = child_bags
  end
end

all_bags = rows.map do |row|
  colour, contains = row.split(' bags contain ')
  if contains == 'no other bags.'
    Bag.new(colour)
  else
    child_bags = contains.split(', ').map { |x| x.match(/(\d+) (.*) bag/).captures }
    Bag.new(colour, *child_bags)
  end
end

# part 1
#def contains_colour?(all_bags, bag, colour)
#  bag.colour == colour || bag.child_bags.any? do |child_count, child_colour|
#    actual_child_bag = all_bags.find { |b| b.colour == child_colour }
#    contains_colour?(all_bags, actual_child_bag, colour)
#  end
#end
#
#result = all_bags.select do |bag|
#  contains_colour?(all_bags, bag, 'shiny gold')
#end
#
## exclude the shiny gold bag itself
#puts result.count - 1

# part 2
def count_children(all_bags, bag)
  bag.child_bags.map do |child_count, child_colour|
    actual_child_bag = all_bags.find { |b| b.colour == child_colour }
    [child_count.to_i, *child_count.to_i.times.map {count_children(all_bags, actual_child_bag)}].sum
  end.sum
end


gold_bag = all_bags.find { |b| b.colour == 'shiny gold' }
puts count_children(all_bags, gold_bag)
