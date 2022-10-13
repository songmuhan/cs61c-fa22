# only check ra, sp, t0-2, s0-1,a0
addi t0, x0, 1
or t1, t0, t0      
addi t0, x0, 0
or t2, t0, t1      
addi t0, x0, 127
or t1, t0, t2
# positive
addi t0, x0, 1
or t1, t0, t0
or t2, t1, t1
or s0, t1, t2
or s1, t1, t0
or a0, t1, t1
or ra, t1, t2
or sp, t1, t3
#negative
addi t0, x0, -1
or t1, t0, t0     
addi t0, x0, 1
or t2, t0, t2     
addi t0, x0, -2048
or t1, t0, t2