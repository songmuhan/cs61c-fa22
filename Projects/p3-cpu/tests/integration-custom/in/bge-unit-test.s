addi t0, x0, 0
addi t1, x0, 1
bge  t1, t0, greater_positive
beq  x0, x0, error


greater_positive:
    addi t0, x0, 1
    addi t1, x0, 1
    bge  t0, t1, equal_positive
    beq  x0,x0,  error



equal_positive:
    addi t0, x0, -1
    addi t1, x0, -1
    bge  t0, t1, equal_negative
    beq  x0,x0,  error

equal_negative:
    addi t0, x0, -1
    bge  x0, t0, greater_negative
    beq  x0,x0,  error
greater_negative:
    addi t0, x0, -1
    addi t1, x0, -2
    bge  t0, t1, finish
    beq  x0,x0,  error


error:
    addi a0, x0, -1
    beq  x0, x0, finish    

finish:
    addi a0, x0, 1






