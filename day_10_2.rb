INPUT = "106,16,254,226,55,2,1,166,177,247,93,0,255,228,60,36"
def calc_knot_hash(input = INPUT)
  list = [*0..255]
  sequence = input.each_codepoint.to_a + [17, 31, 73, 47, 23]
  size = list.size
  current_position = 0
  skip_size = 0
  64.times do
    sequence.each do |length|
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
  end
  outputs = []
  16.times do |idx|
    output = 0
    16.times do |n|
      output ^= list[idx*16+n]
    end
    outputs << output
  end
  hexa_hash = outputs.map do |output|
    hexa = output.to_s(16)
    hexa = "0"+hexa if hexa.size == 1
    hexa
  end
  return hexa_hash.join("")
end
p calc_knot_hash