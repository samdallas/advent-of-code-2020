input = File.read("input.csv").split("\n")

# part 1
@preamble_length = 25
@rows = input.map { |row| row.to_i }

def find_pair(total, loc)
  prev_num = @rows[loc - @preamble_length...loc]

  prev_num.each_with_index do |n1, i|
    prev_num[i...prev_num.length].each do |n2|
      return true if n1 + n2 == total
    end
  end

  return false
end

i = @preamble_length
@rows[@preamble_length..@rows.length].each_with_index do |val|
  unless find_pair(val, i)
      puts val
    break
  end
  i += 1
end


# part 2
@target_val = 105950735

additions = []

def check_array(total, to_sum, array)
  return false if array.empty?
  new_total = total + array.first
  if new_total == @target_val
    return to_sum
  elsif new_total > @target_val
    return false
  else
    return check_array(new_total, to_sum << array.first, array[1..-1])
  end
end

@rows.each_with_index do |val, i|
  output = check_array(val, [val], @rows[i + 1..-1])
  if output
    puts output.min + output.max
    break
  end
end
