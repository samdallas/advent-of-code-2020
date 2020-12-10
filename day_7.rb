# assume no cycles
# Part 1

class DaySeven
  def initialize
    @bag_list = []
  end

  def parse_input
    input = File.read("input.csv").split("\n")
    input.each do |row|
      color = row.split(" ")[0...2].join(" ")
      children = parse_children(row.split(" contain ")[1])

      parent_bag = @bag_list.find { |bag| bag.color == color }

      handle_bag(color, parent_bag, children)
    end
  end
end

class DaySevenPartOne < DaySeven
  Bag = Struct.new(:color, :parents, :visited)

  def handle_bag(color, parent_bag, children)
    if parent_bag.nil?
      parent_bag = Bag.new(color, [], false)
      @bag_list << parent_bag
    end

    children.each do |child|
      child_bag = @bag_list.find {|bag| bag.color == child }
      if child_bag
        child_bag.parents << parent_bag
      else
        @bag_list << Bag.new(child, [parent_bag], false)
      end
    end
  end

  def parse_children(children_str)
    return [] if children_str == "no other bags."

    children_str[0...-1].split(", ").map do |child|
      child.gsub!(/^\d+ | bag.*$/, "")
    end
  end

  def traverse
    parent_queue = Queue.new
    n_parents = 0

    @bag_list.find { |bag| bag.color == "shiny gold" }.parents.each do |bag|
      bag.visited = true
      parent_queue.push(bag)
    end

    while !parent_queue.empty? do
      bag = parent_queue.pop
      n_parents += 1
      bag.parents.each do |bag|
        parent_queue.push(bag) if !bag.visited
        bag.visited = true
      end
    end

    puts "the answer is #{n_parents}"
  end
end

a = DaySevenPartOne.new
a.parse_input
a.traverse


# part 2

class DaySevenPartTwo < DaySeven
  Bag = Struct.new(:color, :children, :visited)
  Child = Struct.new(:count, :bag)

  def handle_bag(color, parent_bag, children)
    if parent_bag.nil?
      parent_bag = Bag.new(color, children, false)
      @bag_list << parent_bag
    else
      parent_bag.children += children
    end
  end

  def parse_children(children_str)
    return [] if children_str == "no other bags."

    children_str[0...-1].split(", ").map do |child|
      color = child.gsub(/^\d+ | bag.*$/, "")
      count = child.split(" ")[0].to_i
      bag = @bag_list.find { |bag| bag.color == color }
      if bag.nil?
        bag = Bag.new(color, [], false)
        @bag_list << bag
      end

      Child.new(count, bag)
    end
  end

  def traverse
    puts n_child_bags(Child.new(1, @bag_list.find { |bag| bag.color == "shiny gold" }))
  end

  def n_child_bags(child)
    total = 0
    return 0 if child.bag.children.empty?
    child.bag.children.each do |child|
      total += child.count * (1 + n_child_bags(child))
    end
    return total
  end
end


b = DaySevenPartTwo.new
b.parse_input
b.traverse

