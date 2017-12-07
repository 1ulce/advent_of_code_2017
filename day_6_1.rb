INPUT = "2 8 8 5 4 2 3 1 5 5 1 2 15  13  5 14"
history = [INPUT.split(" ").map(&:to_i)]
status = history[0].clone
count = 0
while true
  max = status.max
  max_idx = status.find_index { |n| n == max }
  max.times do |n|
    aim_idx = (max_idx + 1 + n) % 16
    status[aim_idx] += 1
  end
  count += 1
  status[max_idx] -= max
  history.push(status.clone)
  break if history.count != history.uniq.count
end
p count