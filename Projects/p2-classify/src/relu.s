.globl relu

.text
# ==============================================================================
# FUNCTION: Performs an inplace element-wise ReLU on an array of ints
# Arguments:
#   a0 (int*) is the pointer to the array
#   a1 (int)  is the # of elements in the array
# Returns:
#   None
# Exceptions:
#   - If the length of the array is less than 1,
#     this function terminates the program with error code 36
# ==============================================================================
relu:
    # Prologue

    li   t0, 1
    blt  a1, t0, exit_error
    li   t0, 0               # t0 = index
loop_start:
    bge  t0, a1, loop_end    # if t0 >= length ,jump to end
    slli t1, t0, 2           # 4 bytes
    add  t1, t1, a0          # get the address of NO.index array
    lw   t2, 0(t1)           # t2 = array[index]
    bge  t2, x0, loop_continue # if t1 >= 0 , jump to continue
    sw   x0, 0(t1)           #  array[index] = 0

loop_continue:
    addi t0, t0, 1
    j loop_start

loop_end:
    # Epilogue
    jr ra

exit_error:
    li a0 36
    j exit