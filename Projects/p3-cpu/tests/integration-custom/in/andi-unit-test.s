# only check ra, sp, t0-2, s0-1,a0
addi t0, x0, 1
andi t1, t0, 1      # t1 should be 1
addi t0, x0, 0
andi t2, t0, 1      # t1 should be 0
addi t0, x0, 127
andi t0, t0, 127
# positive
addi t0, x0, 1
andi t1, t0, 100
andi t2, t1, 1
andi s0, t1, 2
andi s1, t1, 3
andi a0, t1, 4
andi ra, t1, 5
andi sp, t1, 5
#negative
# only check ra, sp, t0-2, s0-1,a0
addi t0, x0, -1
andi t1, t0, 1      # t1 should be 1
addi t0, x0, -256
andi t2, t0, 0      # t1 should be 0
addi t0, x0, -2048
andi t1, t0, 11
