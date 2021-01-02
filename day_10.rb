input = File.read("input.csv").split("\n").map(&:to_i)

# part 1
def possible_next(a, curr_v)
  return [] if a.select { |v| v < curr_v }.any?
  a.select { |v| v - curr_v <= 3 && v - curr_v >= 1 }
end

def find_path(remaining, curr_v, path)
  if remaining.empty?
    return path
  end

  valid_path = possible_next(remaining, curr_v).map do |next_v|
    find_path(remaining - [next_v], next_v, path + [next_v])
  end.find { |x| !x.nil? }
  
  return valid_path
end

def find_diff(path)
  n_1 = 0
  n_3 = 0
  (path.length - 1).times do |i|
    diff = path[i+1] - path[i]
    n_1 += 1 if diff == 1
    n_3 += 1 if diff == 3
  end

  puts n_1 * n_3
end


max_v = input.max + 3
path = find_path(input, 0, [])
find_diff([0] + path + [max_v])


# part 2 # with some light peeking
@sorted = [0] + input.sort
n_ways = {}
@sorted.each { |v| n_ways[v] = 0 }
n_ways[@sorted.first] = 1

def possible_next_2(curr_v)
  @sorted.select { |v| v - curr_v <= 3 && v - curr_v >= 1 }
end

@sorted.each do |curr_v|
  possible_next_2(curr_v).each do |next_v|
    n_ways[next_v] += n_ways[curr_v]
  end
end

puts n_ways[input.max]
