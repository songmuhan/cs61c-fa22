# only check ra, sp, t0-2, s0-1,a0
addi t0, x0, 1
xori t1, t0, 1      
addi t0, x0, 0
xori t2, t0, 1      
addi t0, x0, 127
xori t1, t0, 16
# positive
addi t0, x0, 1
xori t1, t0, 100
xori t2, t1, 1
xori s0, t1, 2
xori s1, t1, 3
xori a0, t1, 4
xori ra, t1, 5
xori sp, t1, 5
#negative
addi t0, x0, -1
xori t1, t0, 1     
addi t0, x0, -256
xori t2, t0, 0     
addi t0, x0, -2048
xori t1, t0, 11