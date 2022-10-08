.globl classify

.text
# =====================================
# COMMAND LINE ARGUMENTS
# =====================================
# Args:
#   a0 (int)        argc
#   a1 (char**)     argv
#   a1[1] (char*)   pointer to the filepath string of m0
#   a1[2] (char*)   pointer to the filepath string of m1
#   a1[3] (char*)   pointer to the filepath string of input matrix
#   a1[4] (char*)   pointer to the filepath string of output file
#   a2 (int)        silent mode, if this is 1, you should not print
#                   anything. Otherwise, you should print the
#                   classification and a newline.
# Returns:
#   a0 (int)        Classification
# Exceptions:
#   - If there are an incorrect number of command line args,
#     this function terminates the program with exit code 31
#   - If malloc fails, this function terminates the program with exit code 26
#
# Usage:
#   main.s <M0_PATH> <M1_PATH> <INPUT_PATH> <OUTPUT_PATH>
classify:
    li   t0, 5     
    bne  t0, a0, error_parameter_number

    addi sp, sp, -56
    sw   a0, 0(sp)
    sw   a1, 4(sp)
    sw   a2, 8(sp)
    sw   ra, 12(sp)
    sw   s0, 16(sp)
    sw   s1, 20(sp)
    sw   s2, 24(sp)
    sw   s3, 28(sp)
    sw   s4, 32(sp) 
    sw   s5, 36(sp)
    sw,  s6, 40(sp)
    sw   s7, 44(sp)
    sw,  s8, 48(sp)
    sw,  ra, 52(sp)

    mv   s1, a1             # pointer to string array

    li   a0, 6
    slli a0, a0, 2          # malloc 6 pointer argument
    jal  ra, malloc
    beqz a0, malloc_error
    mv   s0, a0             # malloced memory base 

    
    # Read pretrained m0
    addi a0, s1, 4
    lw   a0, 0(a0)
    addi a1, s0, 0
    addi a2, s0, 4 
    jal  ra, read_matrix
    mv   s2, a0             # s2 -> m0

    # Read pretrained m1
    addi a0, s1, 8
    lw   a0, 0(a0)
    addi a1, s0, 8
    addi a2, s0, 12
    jal  ra, read_matrix
    mv   s3, a0             # s3 -> m1

    # Read input
    addi a0, s1, 12
    lw   a0, 0(a0)
    addi a1, s0, 16
    addi a2, s0, 20
    jal  ra, read_matrix
    mv   s4, a0             # s4 -> input

    # Compute h = matmul(m0, input)
    addi t0, s0, 0    
    lw   t0, 0(t0)
    addi t1, s0, 20
    lw   t1, 0(t1)
    mul  t2, t0, t1
    mv   s6, t2
    slli t2, t2, 2
    mv   a0, t2
    jal  ra, malloc
    beqz a0, malloc_error
    mv   s5, a0             # s5 -> h  

    mv   a0, s2
    addi t0, s0, 0
    lw   a1, 0(t0)
    addi t0, s0, 4
    lw   a2, 0(t0)
    mv   a3, s4
    addi t0, s0, 16
    lw   a4, 0(t0)
    addi t0, s0, 20
    lw   a5, 0(t0)
    mv   a6, s5
    jal  ra, matmul

    # Compute h = relu(h)
    mv   a0, s5
    mv   a1, s6
    jal  relu
    # Compute o = matmul(m1, h)
    addi t0, s0, 8
    lw   t0, 0(t0)
    addi t1, s0, 20
    lw   t1, 0(t1)
    mul  a0, t0, t1
    mv   s8, a0
    slli a0, a0, 2
    jal  ra, malloc
    beqz a0, malloc_error
    mv   s7, a0

    mv   a0, s3
    addi t0, s0, 8
    lw   a1, 0(t0)
    addi t0, s0, 12
    lw   a2, 0(t0)
    mv   a3, s5
    addi t0, s0, 0
    lw   a4, 0(t0) 
    addi t0, s0, 20
    lw   a5, 0(t0)
    mv   a6, s7
    jal  ra, matmul
    # Write output matrix o
    addi a0, s1, 16
    lw   a0, 0(a0)
    mv   a1, s7
    addi t0, s0, 8
    lw   a2, 0(t0)
    addi t0, s0, 20
    lw   a3, 0(t0)
    jal  ra, write_matrix
    # Compute and return argmax(o)
    mv   a0, s7
    mv   a1, s8
    jal  ra, argmax
    mv   s6, a0
 #   slli t0, t0, 2
#    add  t0, t0, s7
#   lw   s6, 0(t0)

    mv   a0, s0
    jal  ra, free
    mv   a0, s5
    jal  ra, free
    mv   a0, s7
    jal  ra, free

    lw   a2, 8(sp)
    li   t0, 1
    beq  a2, t0, end
    # If enabled, print argmax(o) and newline
    mv   a0, s6
    jal  ra, print_int
    li   a0, '\n'
    jal  ra, print_char
end:

    mv   t0, s6
    lw   a0, 0(sp)
    lw   a1, 4(sp)
    lw   a2, 8(sp)
    lw   ra, 12(sp)
    lw   s0, 16(sp)
    lw   s1, 20(sp)
    lw   s2, 24(sp)
    lw   s3, 28(sp)
    lw   s4, 32(sp) 
    lw   s5, 36(sp)
    lw,  s6, 40(sp)
    lw   s7, 44(sp)
    lw,  s8, 48(sp)
    lw,  ra, 52(sp)
    addi sp, sp, 56
    mv  a0, t0

    jr ra

error_parameter_number:
    li a0, 31
    j exit
malloc_error:
    li a0, 26
    j exit
