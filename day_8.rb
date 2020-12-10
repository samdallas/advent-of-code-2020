input = File.read("input.csv").split("\n")

cmd_list = []
input.each do |row|
  cmd_list << row
end

def execute(cmd_list, i, acc)
  return acc if cmd_list[i].nil?
  cmd, num = cmd_list[i].split
  cmd_list[i] = nil

  case cmd
  when "jmp"
    i += num.to_i
  when "acc"
    acc += num.to_i
    i += 1
  when "nop"
    i += 1
  else
    raise "oh no"
  end

  execute(cmd_list, i, acc)
end

puts execute(cmd_list.clone, 0, 0)


# part 2
def execute_without_branch(cmd_list, i, acc)
  return acc if i == cmd_list.length
  return false if cmd_list[i].nil?

  cmd, num = cmd_list[i].split
  cmd_list[i] = nil

  case cmd
  when "jmp"
    i += num.to_i
  when "acc"
    acc += num.to_i
    i += 1
  when "nop"
    i += 1
  else
    raise "oh no"
  end

  execute_without_branch(cmd_list, i, acc)
end



def execute_with_branch(cmd_list, i, acc)
  cmd, num = cmd_list[i].split
  cmd_list[i] = nil

  case cmd
  when "jmp"
    nop = execute_without_branch(cmd_list.clone, i + 1, acc)
    return nop if nop

    i += num.to_i
  when "acc"
    acc += num.to_i
    i += 1
  when "nop"
    jmp = execute_without_branch(cmd_list.clone, i + num.to_i, acc)
    return jmp if jmp

    i += 1
  else
    raise "oh no"
  end

  execute_with_branch(cmd_list, i, acc)
end

puts execute_with_branch(cmd_list.clone, 0, 0)


