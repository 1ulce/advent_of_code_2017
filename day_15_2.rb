INPUT = <<EOS
Generator A starts with 703
Generator B starts with 516
EOS
a = INPUT.split("\n")[0].split(" ").last.to_i * 16807
b = INPUT.split("\n")[1].split(" ").last.to_i * 48271
array_a = [a]
array_b = [b]
until array_a.size == 5000000
  a = a * 16807 % 2147483647
  array_a << a if a % 4 == 0
end
until array_b.size == 5000000
  b = b * 48271 % 2147483647
  array_b << b if b % 8 == 0
end
count = 0
5000000.times do |n|
  count += 1 if format("%032d", array_a[n].to_s(2))[16..-1] == format("%032d", array_b[n].to_s(2))[16..-1]
end
p count
