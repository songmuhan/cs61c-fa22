.globl write_matrix

.text
# ==============================================================================
# FUNCTION: Writes a matrix of integers into a binary file
# FILE FORMAT:
#   The first 8 bytes of the file will be two 4 byte ints representing the
#   numbers of rows and columns respectively. Every 4 bytes thereafter is an
#   element of the matrix in row-major order.
# Arguments:
#   a0 (char*) is the pointer to string representing the filename
#   a1 (int*)  is the pointer to the start of the matrix in memory
#   a2 (int)   is the number of rows in the matrix
#   a3 (int)   is the number of columns in the matrix
# Returns:
#   None
# Exceptions:
#   - If you receive an fopen error or eof,
#     this function terminates the program with error code 27
#   - If you receive an fclose error or eof,
#     this function terminates the program with error code 28
#   - If you receive an fwrite error or eof,
#     this function terminates the program with error code 30
# ==============================================================================
write_matrix:

    # Prologue
    addi sp, sp, -28
    sw   ra, 0(sp)
    sw   a0, 4(sp)
    sw   a1, 8(sp)
    sw   a2, 12(sp)
    sw   a3, 16(sp)
    sw   s0, 20(sp)
    sw   s1, 24(sp)
    mul  s1, a2, a3           # number of elements to write, set to s1
    li   t0, 1                # write permisson
    mv   a1, t0               # a1 = 1
    jal  ra, fopen
    li   t0, -1
    beq  a0, t0, fopen_error  #fopen fail
    mv   s0, a0               # s0 = file descriptor
#   mv   a0, s0               
    addi  a1, sp, 12
    li    a2, 2
    li    a3, 4
    jal   ra, fwrite
    li    t0, 2
    bne   a0, t0, fwrite_error

    mv   a0, s0               
    lw   a1, 8(sp)            # pointer of matrix in memory
    mv   a2, s1               # number of elements
    li   a3, 4                # each elements is 4 bytes
    jal  ra, fwrite
    bne  a0, s1, fwrite_error # wirte number different from expectation
    
    mv   a0, s0
    jal  ra, fclose
    li   t0, -1
    beq  a0, t0, fclose_error

    # Epilogue
    lw   ra, 0(sp)
    lw   a0, 4(sp)
    lw   a1, 8(sp)
    lw   a2, 12(sp)
    lw   a3, 16(sp)
    lw   s0, 20(sp)
    lw   s1, 24(sp)
    addi sp, sp, 28


    jr ra
fopen_error:
    li   a0, 27
    j exit

fwrite_error:
    li   a0, 30
    j exit

fclose_error:
    li   a0, 28
    j exit