INPUT = 376

array = [0]
current_position = 0
2017.times do |n|
  current_position = (current_position + INPUT) % array.size + 1
  array.insert(current_position, n+1)
end
p array[current_position + 1]