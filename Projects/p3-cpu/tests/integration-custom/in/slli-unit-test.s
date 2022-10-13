# only check ra, sp, t0-2, s0-1,a0
addi t0, x0, 1
slli t1, t0, 1      
addi t0, x0, 0
slli t2, t0, 1      
addi t0, x0, 127
slli t1, t0, 16
# positive
addi t0, x0, 1
slli t1, t0, 20
slli t2, t1, 1
slli s0, t1, 2
slli s1, t1, 3
slli a0, t1, 4
slli ra, t1, 5
slli sp, t1, 5
#negative
addi t0, x0, -1
slli t1, t0, 1     
addi t0, x0, -256
slli t2, t0, 0     
addi t0, x0, -2048
slli t1, t0, 11