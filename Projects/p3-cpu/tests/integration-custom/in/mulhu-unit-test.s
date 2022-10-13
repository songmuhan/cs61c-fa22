# only check ra, sp, t0-2, s0-1,a0
addi t0, x0, -2048
mulhu t1, t0, t0      
addi t0, x0, -2048
mulhu t2, t0, t1      
addi t0, x0, -1
mulhu t1, t0, t2
# positive
addi t0, x0, 2047
mulhu t1, t0, t0
mulhu t2, t1, t1
mulhu s0, t1, t2
mulhu s1, t1, t0
mulhu a0, t1, t1
mulhu ra, t1, t2
mulhu sp, t1, t3
#negative
addi t0, x0, -1
mulhu t1, t0, t0     
addi t0, x0, 1
mulhu t2, t0, t2     
addi t0, x0, -2048
mulhu t1, t0, t2