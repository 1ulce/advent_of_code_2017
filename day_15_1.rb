INPUT = <<EOS
Generator A starts with 703
Generator B starts with 516
EOS
count = 0
a = INPUT.split("\n")[0].split(" ").last.to_i * 16807
b = INPUT.split("\n")[1].split(" ").last.to_i * 48271
40000000.times do |n|
  count += 1 if format("%032d", a.to_s(2))[16..-1] == format("%032d", b.to_s(2))[16..-1]
  a = a * 16807 % 2147483647
  b = b * 48271 % 2147483647
end
p count
