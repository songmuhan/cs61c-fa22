# only check ra, sp, t0-2, s0-1,a0
addi t0, x0, 1
xor t1, t0, t0      
addi t0, x0, 0
xor t2, t0, t1      
addi t0, x0, 127
xor t1, t0, t2
# positive
addi t0, x0, 1
xor t1, t0, t0
xor t2, t1, t1
xor s0, t1, t2
xor s1, t1, t0
xor a0, t1, t1
xor ra, t1, t2
xor sp, t1, t3
#negative
addi t0, x0, -1
xor t1, t0, t0     
addi t0, x0, 1
xor t2, t0, t2     
addi t0, x0, -2048
xor t1, t0, t2