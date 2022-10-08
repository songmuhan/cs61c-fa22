.globl argmax

.text
# =================================================================
# FUNCTION: Given a int array, return the index of the largest
#   element. If there are multiple, return the one
#   with the smallest index.
# Arguments:
#   a0 (int*) is the pointer to the start of the array
#   a1 (int)  is the # of elements in the array
# Returns:
#   a0 (int)  is the first index of the largest element
# Exceptions:
#   - If the length of the array is less than 1,
#     this function terminates the program with error code 36
# =================================================================
argmax:
    # Prologue
    li   t0, 1
    blt  a1, t0, exit_error
    lw   t3, 0(a0)           # t3 is the *value* of the largest
    li   t4, 0               # t4 is the *index* of the largest
    li   t0, 1               # t0 = index, NOTICE: we begin 1 here
loop_start:
    bge  t0, a1, loop_end    # if t0 >= length ,jump to end
    slli t1, t0, 2           # 4 bytes
    add  t1, t1, a0          # get the address of NO.index array
    lw   t2, 0(t1)           # t2 = array[index]
    bge  t3, t2,loop_continue # t3 >= t2, continue. we just keep the first index of the largest element
    mv   t3, t2              # if t2 > t3, set t3 = t2
    mv   t4, t0              # set index to t4
loop_continue:
    addi t0, t0, 1           # increase index
    j loop_start
loop_end:
    # Epilogue
    mv   a0, t4              # set t4 to a0, prepare to return
    jr ra
exit_error:
    li a0 36
    j exit