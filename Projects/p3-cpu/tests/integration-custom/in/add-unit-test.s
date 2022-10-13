# only check ra, sp, t0-2, s0-1,a0
addi t0, x0, 1
add t1, t0, t0      
addi t0, x0, 0
add t2, t0, t1      
addi t0, x0, 127
add t1, t0, t2
# positive
addi t0, x0, 1
add t1, t0, t0
add t2, t1, t1
add s0, t1, t2
add s1, t1, t0
add a0, t1, t1
add ra, t1, t2
add sp, t1, t3
#negative
addi t0, x0, -1
add t1, t0, t0     
addi t0, x0, 1
add t2, t0, t2     
addi t0, x0, -2048
add t1, t0, t2