# only check ra, sp, t0-2, s0-1,a0
addi t0, x0, 1
srai t1, t0, 1      
addi t0, x0, 0
srai t2, t0, 1      
addi t0, x0, 127
srai t1, t0, 16
# positive
addi t0, x0, 1
srai t1, t0, 20
srai t2, t1, 1
srai s0, t1, 2
srai s1, t1, 3
srai a0, t1, 4
srai ra, t1, 5
srai sp, t1, 5
#negative
addi t0, x0, -1
srai t1, t0, 1     
addi t0, x0, -256
srai t2, t0, 0     
addi t0, x0, -2048
srai t1, t0, 11