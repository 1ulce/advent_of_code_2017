INPUT = <<EOS
0: 3
1: 2
2: 4
4: 4
6: 5
8: 6
10: 6
12: 6
14: 6
16: 8
18: 8
20: 8
22: 8
24: 10
26: 8
28: 8
30: 12
32: 14
34: 12
36: 10
38: 12
40: 12
42: 9
44: 12
46: 12
48: 12
50: 12
52: 14
54: 14
56: 14
58: 12
60: 14
62: 14
64: 12
66: 14
70: 14
72: 14
74: 14
76: 14
80: 18
88: 20
90: 14
98: 17
EOS

firewalls = {}
INPUT.split("\n").each do |row|
  firewalls[row.split(" ")[0].to_i] = row.split(" ")[1].to_i
end
sum = 0
(firewalls.keys.max + 1).times do |picosecond|
  if firewalls.keys.include?(picosecond)
    sum += picosecond * firewalls[picosecond] if picosecond % (firewalls[picosecond]*2 - 2) == 0
  end
end
p sum