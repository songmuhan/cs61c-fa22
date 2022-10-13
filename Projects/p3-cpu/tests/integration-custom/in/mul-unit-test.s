# only check ra, sp, t0-2, s0-1,a0
addi t0, x0, 4
mul t1, t0, t0      
addi t0, x0, 2047
mul t2, t0, t1      
addi t0, x0, 2047
mul t1, t0, t2
# positive
addi t0, x0, 4
mul t1, t0, t0
mul t2, t1, t1
mul s0, t1, t2
mul s1, t1, t0
mul a0, t1, t1
mul ra, t1, t2
mul sp, t1, t3
#negative
addi t0, x0, -1
mul t1, t0, t0     
addi t0, x0, 1
mul t2, t0, t2     
addi t0, x0, -2048
mul t1, t0, t2