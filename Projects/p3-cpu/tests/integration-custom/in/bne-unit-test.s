addi t0, x0, 0
addi t1, x0, 1
bne  t0, t1, not_equal_positive
beq  x0, x0, error
not_equal_positive:
    addi t0,x0,-1
    addi t1,x0,-2
    bne  t0,t1,not_equal_negative
    beq  x0, x0, error
not_equal_negative:
    addi t0, x0, 1
    bne  x0, x0, error
    beq  x0, x0, finish
error:
    addi a0, x0, -1
finish:
    addi a0, x0, 1

