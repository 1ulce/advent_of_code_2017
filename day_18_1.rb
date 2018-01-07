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
n = 0
status = {}
answer = nil

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

while true
  action = instructions[n].split(" ")
  case action[0]
  when "set"
    status[action[1]] = to_int(action[2], status)
    n += 1
  when "snd"
    status[action[1]] = 0 unless status[action[1]]
    status["snd_" + action[1]] = status[action[1]]
    n += 1
  when "add"
    status[action[1]] = 0 unless status[action[1]]
    status[action[1]] += to_int(action[2], status)
    n += 1
  when "mul"
    status[action[1]] = 0 unless status[action[1]]
    status[action[1]] *= to_int(action[2], status)
    n += 1
  when "mod"
    status[action[1]] = 0 unless status[action[1]]
    status[action[1]] = status[action[1]] % to_int(action[2], status)
    n += 1
  when "rcv"
    if status[action[1]] > 0 && status["snd_" + action[1]] != nil
      break answer = status["snd_" + action[1]]
    end
    n += 1
  when "jgz"
    if status[action[1]] > 0
      n += to_int(action[2], status)
    else
      n += 1
    end
  end
end
p answer
