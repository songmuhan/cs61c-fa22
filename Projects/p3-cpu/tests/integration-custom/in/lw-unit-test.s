addi t0, x0, -1
lui  a0, 554580
sw   t0, 0(a0)
addi t0, t0, 1
sw   t0, 4(a0)
addi t0, t0, 1
sw   t0, -4(a0)
addi t0, t0, 1
sw   t0, -8(a0)
lw   t0, -8(a0)
lw   t0, -4(a0)
lw   t0, 0(a0)
lw   t0, 4(a0)
