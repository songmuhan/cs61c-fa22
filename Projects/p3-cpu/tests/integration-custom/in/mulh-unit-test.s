# only check ra, sp, t0-2, s0-1,a0
addi t0, x0, 2047
mulh t1, t0, t0      
addi t0, x0, -2048
mulh t2, t0, t1      
addi t0, x0, -100
mulh t1, t0, t2
# positive
addi t0, x0, 2047
mulh t1, t0, t0
mulh t2, t1, t1
mulh s0, t1, t2
mulh s1, t1, t0
mulh a0, t1, t1
mulh ra, t1, t2
mulh sp, t1, t3
#negative
addi t0, x0, -1
mulh t1, t0, t0     
addi t0, x0, 1
mulh t2, t0, t2     
addi t0, x0, -2048
mulh t1, t0, t2