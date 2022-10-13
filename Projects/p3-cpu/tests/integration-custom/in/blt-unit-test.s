addi t0, x0, 0
addi t1, x0, 1
blt  t0, t1, less_positive
beq  x0, x0, error
less_positive:
    addi t0, x0, -1
    addi t1, x0, -2
    blt  t0, t1, finish
    beq  x0,x0,  error
error:
    addi a0, x0, -1
    beq  x0, x0, finish    

finish:
    addi a0, x0, 1






