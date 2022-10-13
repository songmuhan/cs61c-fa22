# only check ra, sp, t0-2, s0-1,a0
addi t0, x0, 1
ori t1, t0, 1      
addi t0, x0, 0
ori t2, t0, 1      
addi t0, x0, 127
ori t1, t0, 16
# positive
addi t0, x0, 1
ori t1, t0, 100
ori t2, t1, 1
ori s0, t1, 2
ori s1, t1, 3
ori a0, t1, 4
ori ra, t1, 5
ori sp, t1, 5
#negative
addi t0, x0, -1
ori t1, t0, 1     
addi t0, x0, -256
ori t2, t0, 0     
addi t0, x0, -2048
ori t1, t0, 11