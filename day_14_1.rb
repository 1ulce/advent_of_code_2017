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
puts output.count("1")