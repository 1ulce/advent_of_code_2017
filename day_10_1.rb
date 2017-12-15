INPUT = "106,16,254,226,55,2,1,166,177,247,93,0,255,228,60,36"
list = [*0..255]
size = list.size
current_position = 0
skip_size = 0
INPUT.split(",").map(&:to_i).each do |length|
  unless length == 0
    if current_position == 0
      new_list = list
    else
      new_list = list[current_position .. -1] + list[0 .. current_position - 1]
    end
    new_list[0 .. length - 1] = new_list[0 .. length - 1].reverse
    list[current_position .. -1] = new_list[0 .. (size-1) - current_position]
    list[0 .. current_position - 1] = new_list[((size-1) - current_position + 1) % size .. -1]
  end
  current_position = (current_position + length + skip_size) % size
  skip_size += 1
end
p list[0] * list[1]