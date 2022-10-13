addi t0, x0, 1
addi t1, x0, 1
beq  t0, t1, equal_positive
beq  x0, x0, error
equal_positive:
    addi t0,x0,-1
    addi t1,x0,-1
    beq  t0,t1,equal_negative
    beq  x0, x0, error
equal_negative:
    addi t0, x0, 1
    beq  x0, t0, error
    beq  x0, x0, finish
error:
    addi a0, x0, -1
finish:
    addi a0, x0, 1

