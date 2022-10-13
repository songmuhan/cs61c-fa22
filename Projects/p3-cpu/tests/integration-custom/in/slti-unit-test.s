# only check ra, sp, t0-2, s0-1,a0
addi t0, x0, 1
slti t1, t0, 1      
addi t0, x0, 0
slti t2, t0, 1      
addi t0, x0, 127
slti t1, t0, 16
# positive
addi t0, x0, 1
slti t1, t0, 100
slti t2, t1, 1
slti s0, t1, 2
slti s1, t1, 3
slti a0, t1, 4
slti ra, t1, 5
slti sp, t1, 5
#negative
addi t0, x0, -1
slti t1, t0, 1     
addi t0, x0, -256
slti t2, t0, 0     
addi t0, x0, -2048
slti t1, t0, 11