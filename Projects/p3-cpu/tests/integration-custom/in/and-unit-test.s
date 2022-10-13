# only check ra, sp, t0-2, s0-1,a0
addi t0, x0, 1
and t1, t0, t0      
addi t0, x0, 0
and t2, t0, t1      
addi t0, x0, 127
and t1, t0, t2
# positive
addi t0, x0, 1
and t1, t0, t0
and t2, t1, t1
and s0, t1, t2
and s1, t1, t0
and a0, t1, t1
and ra, t1, t2
and sp, t1, t3
#negative
addi t0, x0, -1
and t1, t0, t0     
addi t0, x0, 1
and t2, t0, t2     
addi t0, x0, -2048
and t1, t0, t2