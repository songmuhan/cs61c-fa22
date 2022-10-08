.globl dot

.text
# =======================================================
# FUNCTION: Dot product of 2 int arrays
# Arguments:
#   a0 (int*) is the pointer to the start of arr0
#   a1 (int*) is the pointer to the start of arr1
#   a2 (int)  is the number of elements to use
#   a3 (int)  is the stride of arr0
#   a4 (int)  is the stride of arr1
# Returns:
#   a0 (int)  is the dot product of arr0 and arr1
# Exceptions:
#   - If the length of the array is less than 1,
#     this function terminates the program with error code 36
#   - If the stride of either array is less than 1,
#     this function terminates the program with error code 37
# =======================================================
dot:

    # Prologue
    li   t0, 1      
    blt  a2, t0, error_length # check length of two array
    blt  a3, t0, error_stride # check stride of arr0
    blt  a4, t0, error_stride # check stride of arr1
    li   t0, 0                # t0 = index of arr0, begin with 0
    li   t1, 0                # t1 = index of arr1, begin with 0 
    li   t4, 0                # t4 = dot product of two array
    li   t6, 0                # counter.
loop_start:
    bge  t6, a2, loop_end     # if counter >= number of elements to use
    slli t2, t0, 2            # 4 bytes
    add  t2, t2, a0           # get the address of No.index element in arra0
    lw   t2, 0(t2)            # t2 = arr0[index]
    slli t3, t1, 2            # 4 bytes
    add  t3, t3, a1           # get the address of No.index element in arra1
    lw   t3, 0(t3)            # t3 = arr1[index]
    mul  t5, t2, t3           # t5 = arr0[index] * arr1[index]
    add  t4, t4, t5           # t4 = sum of dot
    add  t0, t0, a3           # update index of arr0
    add  t1, t1, a4           # update index of arr1
    addi t6, t6, 1            # update counter 
    j loop_start
loop_end:

    # Epilogue
    mv a0, t4              #put sum to a0
    jr ra

error_length:

    li a0, 36
    j exit

error_stride:
    
    li a0, 37
    j exit


