require './day_10_2.rb'
PUZZLE_INPUT = "wenycdww"
output = <<EOS
EOS
128.times do |n|
  bits = ""
  calc_knot_hash(PUZZLE_INPUT+"-"+(n).to_s).chars.each do |hex_st|
    bit = hex_st.to_i(16).to_s(2)
    until bit.size == 4
      bit = "0" + bit
    end
    bits += bit
  end
  output << bits+"\n"
end

grid_hash = {}
pre_regions = 1
grid = output.split("\n")

def conv_to_grid_str(int)
  format("%03d", int)
end

128.times do |row_n|
  row = row_n
  128.times do |column_n|
    column = column_n
    st_row = conv_to_grid_str(row)
    st_column = conv_to_grid_str(column)
    if grid[row][column] == "1"
      top = grid_hash[conv_to_grid_str(row - 1) + st_column] || 0
      left = grid_hash[st_row + conv_to_grid_str(column - 1)] || 0
      if top == 0 && left == 0
        grid_hash[st_row + st_column] = pre_regions
        pre_regions += 1
      elsif top == left
        grid_hash[st_row + st_column] = top
      elsif top != 0 && left == 0
        grid_hash[st_row + st_column] = top
      elsif top == 0 && left != 0
        grid_hash[st_row + st_column] = left
      else
        small = [top, left].min
        big = [top, left].max
        grid_hash.each {|k,v| grid_hash[k] = small if v == big}
        grid_hash[st_row + st_column] = small
      end
    else
      grid_hash[st_row + st_column] = 0
    end
  end
end
p grid_hash.values.uniq.sort.drop(1).count