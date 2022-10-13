# only check ra, sp, t0-2, s0-1,a0
addi t0, x0, 1
addi t1, t0, 1      
addi t0, x0, 0
addi t2, t0, 1      
addi t0, x0, 127
addi t1, t0, 16
# positive
addi t0, x0, 1
addi t1, t0, 100
addi t2, t1, 1
addi s0, t1, 2
addi s1, t1, 3
addi a0, t1, 4
addi ra, t1, 5
addi sp, t1, 5
#negative
addi t0, x0, -1
addi t1, t0, 1     
addi t0, x0, -256
addi t2, t0, 0     
addi t0, x0, -2048
addi t1, t0, 11