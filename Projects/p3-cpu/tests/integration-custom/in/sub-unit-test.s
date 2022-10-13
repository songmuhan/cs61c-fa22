# only check ra, sp, t0-2, s0-1,a0
addi t0, x0, 1
sub t1, t0, t0      
addi t0, x0, 0
sub t2, t0, t1      
addi t0, x0, 127
sub t1, t0, t2
# positive
addi t0, x0, 1
sub t1, t0, t0
sub t2, t1, t1
sub s0, t1, t2
sub s1, t1, t0
sub a0, t1, t1
sub ra, t1, t2
sub sp, t1, t3
#negative
addi t0, x0, -1
sub t1, t0, t0     
addi t0, x0, 1
sub t2, t0, t2     
addi t0, x0, -2048
sub t1, t0, t2