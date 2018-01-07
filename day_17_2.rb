INPUT = 376

current_position = 0
answer = nil
50000000.times do |n|
  current_position = (current_position + INPUT) % (n+1) + 1
  answer = n+1 if current_position == 1
end
p answer