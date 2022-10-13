# only check ra, sp, t0-2, s0-1,a0
addi t0, x0, 1
sra t1, t0, t0      
addi t0, x0, 0
sra t2, t0, t1      
addi t0, x0, 127
sra t1, t0, t2
# positive
addi t0, x0, 1
sra t1, t0, t0
sra t2, t1, t1
sra s0, t1, t2
sra s1, t1, t0
sra a0, t1, t1
sra ra, t1, t2
sra sp, t1, t3
#negative
addi t0, x0, -1
sra t1, t0, t0     
addi t0, x0, 1
sra t2, t0, t2     
addi t0, x0, -2048
sra t1, t0, t2