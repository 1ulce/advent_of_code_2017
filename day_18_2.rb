INPUT = <<EOS
set i 31
set a 1
mul p 17
jgz p p
mul a 2
add i -1
jgz i -2
add a -1
set i 127
set p 622
mul p 8505
mod p a
mul p 129749
add p 12345
mod p a
set b p
mod b 10000
snd b
add i -1
jgz i -9
jgz a 3
rcv b
jgz b -1
set f 0
set i 126
rcv a
rcv b
set p a
mul p -1
add p b
jgz p 4
snd a
set a b
jgz 1 3
snd b
set f 1
add i -1
jgz i -11
snd a
jgz f -16
jgz a -19
EOS

instructions = INPUT.split("\n")
n = counter = 0
deadlock = [false, false]
status_0 = {"p" => 0, "n" => 0}
queue_0 = []
status_1 = {"p" => 1, "n" => 0}
queue_1 = []

def to_int(string, status)
  if !string.match(/\D/)
    return string.to_i
  elsif string.start_with?("-")
    return string.to_i
  else
    status[string] = 0 unless status[string]
    return status[string]
  end
end

until deadlock == [true, true]
  2.times do |n|
    status = eval("status_" + n.to_s)
    action = instructions[status["n"]].split(" ")
    case action[0]
    when "set"
      status[action[1]] = to_int(action[2], status)
      status["n"] += 1
    when "snd"
      counter += 1 if n == 1
      eval("queue_" + ((n + 1) % 2).to_s) << to_int(action[1], status)
      status["n"] += 1
    when "add"
      status[action[1]] = 0 unless status[action[1]]
      status[action[1]] += to_int(action[2], status)
      status["n"] += 1
    when "mul"
      status[action[1]] = 0 unless status[action[1]]
      status[action[1]] *= to_int(action[2], status)
      status["n"] += 1
    when "mod"
      status[action[1]] = 0 unless status[action[1]]
      status[action[1]] = status[action[1]] % to_int(action[2], status)
      status["n"] += 1
    when "rcv"
      queue = eval("queue_" + n.to_s)
      if queue.size > 0
        status[action[1]] = queue.first
        queue.shift
        status["n"] += 1
        deadlock[n] = false
      else
        deadlock[n] = true
      end
    when "jgz"
      if to_int(action[1], status) > 0
        status["n"] += to_int(action[2], status)
      else
        status["n"] += 1
      end
    end
    eval("status_" + n.to_s + "= status")
  end
end
p counter
