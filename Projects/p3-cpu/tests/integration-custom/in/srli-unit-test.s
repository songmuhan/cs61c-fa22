# only check ra, sp, t0-2, s0-1,a0
addi t0, x0, 1
srli t1, t0, 1      
addi t0, x0, 0
srli t2, t0, 1      
addi t0, x0, 127
srli t1, t0, 16
# positive
addi t0, x0, 1
srli t1, t0, 20
srli t2, t1, 1
srli s0, t1, 2
srli s1, t1, 3
srli a0, t1, 4
srli ra, t1, 5
srli sp, t1, 5
#negative
addi t0, x0, -1
srli t1, t0, 1     
addi t0, x0, -256
srli t2, t0, 0     
addi t0, x0, -2048
srli t1, t0, 11