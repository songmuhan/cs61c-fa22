.globl matmul

.text
# =======================================================
# FUNCTION: Matrix Multiplication of 2 integer matrices
#   d = matmul(m0, m1)
# Arguments:
#   a0 (int*)  is the pointer to the start of m0
#   a1 (int)   is the # of rows (height) of m0
#   a2 (int)   is the # of columns (width) of m0
#   a3 (int*)  is the pointer to the start of m1
#   a4 (int)   is the # of rows (height) of m1
#   a5 (int)   is the # of columns (width) of m1
#   a6 (int*)  is the pointer to the the start of d
# Returns:
#   None (void), sets d = matmul(m0, m1)
# Exceptions:
#   Make sure to check in top to bottom order!
#   - If the dimensions of m0 do not make sense,
#     this function terminates the program with exit code 38
#   - If the dimensions of m1 do not make sense,
#     this function terminates the program with exit code 38
#   - If the dimensions of m0 and m1 don't match,
#     this function terminates the program with exit code 38
# =======================================================

# pesudocode of matmul using dot product
#   dot product:
#       a0 (int*) is the pointer to the start of arr0
#       a1 (int*) is the pointer to the start of arr1
#       a2 (int)  is the number of elements to use
#       a3 (int)  is the stride of arr0
#       a4 (int)  is the stride of arr1
# Returns:
#   a0 (int)  is the dot product of arr0 and arr1
#
# Matirx Row major storage
#   A: m x n   B: n x k    C: m x k  
#   for i in [0,m):
#       for j in [0, k):
#           C[i+j] = dot product(
#                       a0 <- n * i + start address of A
#                       a1 <- j + start address of B
#                       a2 <- n
#                       a3 <- 1
#                       a4 <- k 
#                   )
# =========================================
matmul:

    # Error checks
    li  t0, 1
    blt a1, t0, error_exit
    blt a2, t0, error_exit
    blt a4, t0, error_exit
    blt a5, t0, error_exit
    bne a2, a4, error_exit
    # Prologue
    li  t0, 0                   # t0 = i, outer loop index
    li  t1, 0                   # t1 = j, inner loop index
    li  t2, 0                   # t2 = index of d
outer_loop_start:
    bge t0, a1, outer_loop_end  # if i >= m, jump to end
    li  t1, 0                   # set j = 0, go into the inner loop
inner_loop_start:
    bge t1, a5, inner_loop_end  # if j >= k, jump to inner_loop end

    addi sp, sp, -44            # prepare to call dot product
    sw   ra, 0(sp)                
    sw   a0, 4(sp)
    sw   a1, 8(sp)
    sw   a2, 12(sp)
    sw   a3, 16(sp)
    sw   a4, 20(sp)
    sw   a5, 24(sp)
    sw   a6, 28(sp)
    sw   t0, 32(sp)
    sw   t1, 36(sp)
    sw   t2, 40(sp)
    
# set parameter of dot 
    mul  t2, t0, a2             # t2 = i * n
    slli t2, t2, 2              # 4 bytes
    add  a0, t2, a0             # a0 <- n * i + start addr of A
    slli t3, t1, 2
    add  a1, t3, a3             # a1 <- j + start addr of B
#    mv   a2, a2                # a2 <- n
    addi a3, x0, 1              # a3 <- 1
    mv   a4, a5                 # a4 <- k

    jal  ra dot                 # call dot

    mv   t3, a0                 # set return value of dot to t3

    lw   ra, 0(sp)                
    lw   a0, 4(sp)
    lw   a1, 8(sp)
    lw   a2, 12(sp)
    lw   a3, 16(sp)
    lw   a4, 20(sp)
    lw   a5, 24(sp)
    lw   a6, 28(sp)
    lw   t0, 32(sp)
    lw   t1, 36(sp) 
    lw   t2, 40(sp)
    addi sp, sp, 44            # restore previous value
    
    slli t4, t2, 2             # 4 bytes
    add  t4, t4, a6            # save to this memory
    sw   t3, 0(t4)             # save value

    addi t1, t1, 1             # update j
    addi t2, t2, 1             # update index of d
    j inner_loop_start
inner_loop_end:
    addi t0, t0, 1             # update i
    j outer_loop_start
outer_loop_end:

    # Epilogue


    jr ra

error_exit:
    li a0, 38
    j exit