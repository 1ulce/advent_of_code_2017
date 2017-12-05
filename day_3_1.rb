INPUT= 325489

square = Math.sqrt(INPUT).to_i
square.even? ? square += 1 : square += 2

depth = (square - 1) / 2

to_edge = square ** 2 - INPUT
mid_side = (square - 1) / 2
to_mid = (mid_side - (to_edge % (square - 1))).abs

p to_mid + depth