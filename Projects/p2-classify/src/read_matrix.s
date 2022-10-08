.globl read_matrix

.text
# ==============================================================================
# FUNCTION: Allocates memory and reads in a binary file as a matrix of integers
#
# FILE FORMAT:
#   The first 8 bytes are two 4 byte ints representing the # of rows and columns
#   in the matrix. Every 4 bytes afterwards is an element of the matrix in
#   row-major order.
# Arguments:
#   a0 (char*) is the pointer to string representing the filename
#   a1 (int*)  is a pointer to an integer, we will set it to the number of rows
#   a2 (int*)  is a pointer to an integer, we will set it to the number of columns
# Returns:
#   a0 (int*)  is the pointer to the matrix in memory
# Exceptions:
#   - If malloc returns an error,
#     this function terminates the program with error code 26
#   - If you receive an fopen error or eof,
#     this function terminates the program with error code 27
#   - If you receive an fclose error or eof,
#     this function terminates the program with error code 28
#   - If you receive an fread error or eof,
#     this function terminates the program with error code 29
# ==============================================================================
# procedure:
#    fopen(filename)
#    fread -> row & coloum
#    malloc row * coloum
#    loop: fread
#    fclose
# ==============================================================================

read_matrix:

    # Prologue
    addi sp, sp, -28
    sw   a0, 0(sp)
    sw   a1, 4(sp)
    sw   a2, 8(sp)
    sw   ra, 12(sp)
    sw   s1, 16(sp)
    sw   s2, 20(sp)
    sw   s3, 24(sp)
#call fopen
    mv   a1, x0                     # set a1 = 0
    jal  ra, fopen                  # call fread
    li   t0, -1
    beq  a0, t0,fopen_error         # if a0 == -1, fail to open

    mv   s1, a0                     # s1 = a0 , file descriptor
#call fread to read row & col first
    # mv   a0, s1                   # a0 is file descripor
    lw   a1, 4(sp)                  # set a1 = pointer to row
    li   a2, 4                      
    jal  ra, fread
    li   a2, 4
    bne  a2, a0, fread_error        # read bytes different from expectation
    
    lw   a2, 8(sp)
    mv   a0, s1
    mv   a1, a2                     # set a1 = pounter to col
    li   a2, 4                      
    jal  ra, fread
    li   a2, 4
    bne  a2, a0, fread_error        # read bytes different from expectation
# call malloc
    lw   a1, 4(sp)
    lw   t0, 0(a1)                  # number of row
    lw   a2, 8(sp)
    lw   t1, 0(a2)                  # number of col
    mul  s2, t0, t1                 # number of bytes to malloc
    slli s2, s2, 2 
    mv   a0, s2
    jal  ra, malloc                 
    beqz a0, malloc_error           # if a0 == 0, malloc failed
    mv   s3, a0
    mv   a1, a0
    mv   a0, s1
    mv   a2, s2
    jal  ra, fread
    bne  s2, a0, fread_error 

# call fclose
    mv   a0, s1
    jal  ra, fclose
    bnez a0, fclose_error
    # Epilogue
    mv   a0, s3
    lw   a1, 4(sp)
    lw   a2, 8(sp)
    lw   ra, 12(sp)
    lw   s1, 16(sp)
    lw   s2, 20(sp)
    lw   s3, 24(sp)
    addi sp, sp, 28
    jr   ra

malloc_error:
    li   a0, 26
    j exit

fopen_error:
    li   a0, 27
    j exit

fclose_error:
    li   a0, 28
    j exit

fread_error:
    li   a0, 29
    j exit