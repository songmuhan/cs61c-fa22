# only check ra, sp, t0-2, s0-1,a0
addi t0, x0, 1
sll t1, t0, t0      
addi t0, x0, 0
sll t2, t0, t1      
addi t0, x0, 127
sll t1, t0, t2
# positive
addi t0, x0, 1
sll t1, t0, t0
sll t2, t1, t1
sll s0, t1, t2
sll s1, t1, t0
sll a0, t1, t1
sll ra, t1, t2
sll sp, t1, t3
#negative
addi t0, x0, -1
sll t1, t0, t0     
addi t0, x0, 1
sll t2, t0, t2     
addi t0, x0, -2048
sll t1, t0, t2