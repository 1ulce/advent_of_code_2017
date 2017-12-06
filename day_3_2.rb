INPUT = 325489

lines = [{rank: 1, pos: {x: 0, y: 0}, num: 1, direction: 1}]
n = 1
sum = 0
is_finish = false
while true
  last = lines.last
  direction = last[:direction]
  case direction
  when 0
    pos = {x: last[:pos][:x], y: last[:pos][:y]+1}
    relative_poses = [[0,-1],[-1,-1],[-1,1],[-1,0]]
  when 1
    pos = {x: last[:pos][:x]+1, y: last[:pos][:y]}
    relative_poses = [[-1,0],[-1,1],[1,1],[0,1]]
  when 2
    pos = {x: last[:pos][:x], y: last[:pos][:y]-1}
    relative_poses = [[0,1],[1,-1],[1,1],[1,0]]
  when 3
    pos = {x: last[:pos][:x]-1, y: last[:pos][:y]}
    relative_poses = [[1,0],[-1,-1],[1,-1],[0,-1]]
  end
  
  sum = 0
  has_left = false
  
  relative_poses.each_with_index do |relative_pos,idx|
    search_pos = {x: pos[:x]+relative_pos[0], y: pos[:y]+relative_pos[1]}
    lines.each do |line|
      if line[:pos] == search_pos
        has_left = true if idx == 3
        sum += line[:num]
      end
    end
  end
  n += 1
  direction = (direction - 1) % 4 unless has_left
  new_last = {rank: n, pos: pos, num: sum, direction: direction}
  lines << new_last
  break if sum > INPUT
end
p lines.last[:num]