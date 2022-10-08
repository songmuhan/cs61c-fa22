from array import array
import sys
import unittest
from framework import AssemblyTest, print_coverage, _venus_default_args, save_assembly
from tools.check_hashes import check_hashes

"""
Coverage tests for project 2 is meant to make sure you understand
how to test RISC-V code based on function descriptions.
Before you attempt to write these tests, it might be helpful to read
unittests.py and framework.py.
Like project 1, you can see your coverage score by submitting to gradescope.
The coverage will be determined by how many lines of code your tests run,
so remember to test for the exceptions!
"""

"""
abs_loss
# =======================================================
# FUNCTION: Get the absolute difference of 2 int arrays,
#   store in the result array and compute the sum
# Arguments:
#   a0 (int*) is the pointer to the start of arr0
#   a1 (int*) is the pointer to the start of arr1
#   a2 (int)  is the length of the arrays
#   a3 (int*) is the pointer to the start of the result array

# Returns:
#   a0 (int)  is the sum of the absolute loss
# Exceptions:
# - If the length of the array is less than 1,
#   this function terminates the program with error code 36.
# =======================================================
"""


class TestAbsLoss(unittest.TestCase):
    def test_abs_loss_standard(self):
        # load the test for abs_loss.s
        t = AssemblyTest(self, "../coverage-src/abs_loss.s")
        # create array0 in the data section
        array0 = t.array([i for i in range(1,10)])
        # load address of `array0` into register a0
        t.input_array("a0",array0)
        # create array1 in the data section
        array1 = t.array([1 if i % 2 == 0 else 6 for i in range(0,9)])
        # load address of `array1` into register a1
        t.input_array("a1",array1)
        # set a2 to the length of the array
        t.input_scalar("a2",len(array0))
        # create a result array in the data section (fill values with -1)
        result = t.array([-1] * len(array0))
        # load address of `array2` into register a3
        t.input_array("a3",result)
        # call the `abs_loss` function
        t.call("abs_loss")
        # check that the result array contains the correct output
        t.check_array(result,[0,4,2,2,4,0,6,2,8])
        # check that the register a0 contains the correct output
        t.check_scalar("a0",28)
        # generate the `assembly/TestAbsLoss_test_simple.s` file and run it through venus
        t.execute()

    # Add other test cases if neccesary
    def test_abs_loss_length_error(self):
        # load the test for abs_loss.s
        t = AssemblyTest(self, "../coverage-src/abs_loss.s")
        # create array0 in the data section
        array0 = t.array([i for i in range(1,10)])
        # load address of `array0` into register a0
        t.input_array("a0",array0)
        # create array1 in the data section
        array1 = t.array([1 if i % 2 == 0 else 6 for i in range(0,9)])
        # load address of `array1` into register a1
        t.input_array("a1",array1)
        # set a2 to the length of the array
        t.input_scalar("a2",-1)
        # create a result array in the data section (fill values with -1)
        result = t.array([-1] * len(array0))
        # load address of `array2` into register a3
        t.input_array("a3",result)
        # call the `abs_loss` function
        t.call("abs_loss")
        # check that the result array contains the correct output
       # t.check_array(result,[0,4,2,2,4,0,6,2,8])
        # check that the register a0 contains the correct output
      #  t.check_scalar("a0",28)
        # generate the `assembly/TestAbsLoss_test_simple.s` file and run it through venus
        t.execute(code=36)

    @classmethod
    def tearDownClass(cls):
        print_coverage("abs_loss.s", verbose=False)


"""
squared_loss
# =======================================================
# FUNCTION: Get the squared difference of 2 int arrays,
#   store in the result array and compute the sum
# Arguments:
#   a0 (int*) is the pointer to the start of arr0
#   a1 (int*) is the pointer to the start of arr1
#   a2 (int)  is the length of the arrays
#   a3 (int*) is the pointer to the start of the result array

# Returns:
#   a0 (int)  is the sum of the squared loss
# Exceptions:
# - If the length of the array is less than 1,
#   this function terminates the program with error code 36.
# =======================================================
"""


class TestSquaredLoss(unittest.TestCase):
    def test_squared_loss_standard(self):
        # load the test for squared_loss.s
        t = AssemblyTest(self, "../coverage-src/squared_loss.s")
        array0 = t.array([i for i in range(1,10)])
        t.input_array("a0",array0)
        array1 = t.array([1 if i % 2 == 0 else 6 for i in range(0,9)])
        t.input_array("a1",array1)
        t.input_scalar("a2",len(array0))
        result = t.array([-1] * len(array0))
        t.input_array("a3",result)
        t.call("squared_loss")
        t.check_array(result,[0,16,4,4,16,0,36,4,64])
        # check that the register a0 contains the correct output
        t.check_scalar("a0",144)
        # generate the `assembly/TestAbsLoss_test_simple.s` file and run it through venus
        t.execute()

    # Add other test cases if neccesary
    def test_squared_loss_length_error(self):
        # load the test for squared_loss.s
        t = AssemblyTest(self, "../coverage-src/squared_loss.s")
        array0 = t.array([i for i in range(1,10)])
        t.input_array("a0",array0)
        array1 = t.array([1 if i % 2 == 0 else 6 for i in range(0,9)])
        t.input_array("a1",array1)
        t.input_scalar("a2",-1)
        result = t.array([-1] * len(array0))
        t.input_array("a3",result)
        t.call("squared_loss")
     #   t.check_array(result,[0,16,4,4,16,0,36,4,64])
        # check that the register a0 contains the correct output
      #  t.check_scalar("a0",144)
        # generate the `assembly/TestAbsLoss_test_simple.s` file and run it through venus
        t.execute(code=36)

    @classmethod
    def tearDownClass(cls):
        print_coverage("squared_loss.s", verbose=False)


"""
zero_one_loss
# =======================================================
# FUNCTION: Generates a 0-1 classifer array inplace in the result array,
#  where result[i] = (arr0[i] == arr1[i])
# Arguments:
#   a0 (int*) is the pointer to the start of arr0
#   a1 (int*) is the pointer to the start of arr1
#   a2 (int)  is the length of the arrays
#   a3 (int*) is the pointer to the start of the result array

# Returns:
#   NONE
# Exceptions:
# - If the length of the array is less than 1,
#   this function terminates the program with error code 36.
# =======================================================
"""


class TestZeroOneLoss(unittest.TestCase):
    def test_zero_one_loss_all_different(self):
        # load the test for zero_one_loss.s
        t = AssemblyTest(self, "../coverage-src/zero_one_loss.s")

        # raise NotImplementedError("TODO")

        # create input arrays in the data section
        array0 = t.array([1] * 5)
        array1 = t.array([0] * 5)
        # load array addresses into argument registers
        t.input_array("a0",array0)
        t.input_array("a1",array1)
        # load array length into argument register
        t.input_scalar("a2",len(array0))
        # create a result array in the data section (fill values with -1)
        result = t.array([-1] * len(array0))
        # load result array address into argument register
        t.input_array("a3",result)
        # call the `zero_one_loss` function
        t.call("zero_one_loss")
        # check that the result array contains the correct output
        correct = [0 for _ in range(len(array0))]
        t.check_array(result, correct)
        # generate the `assembly/TestZeroOneLoss_test_simple.s` file and run it through venus
        t.execute()

    # Add other test cases if neccesary
    def test_zero_one_loss_length_error(self):
        t = AssemblyTest(self, "../coverage-src/zero_one_loss.s")
        # create input arrays in the data section
        array0 = t.array([1] * 5)
        array1 = t.array([0] * 5)
        # load array addresses into argument registers
        t.input_array("a0",array0)
        t.input_array("a1",array1)
        # load array length into argument register
        t.input_scalar("a2",-1)
        # create a result array in the data section (fill values with -1)
        result = t.array([-1] * len(array0))
        # load result array address into argument register
        t.input_array("a3",result)
        # call the `zero_one_loss` function
        t.call("zero_one_loss")
        # check that the result array contains the correct output
        correct = [0 for _ in range(len(array0))]
    #    t.check_array(result, correct)
        t.execute(code=36)
    def test_zero_one_loss_standard(self):
        t = AssemblyTest(self, "../coverage-src/zero_one_loss.s")
        # create input arrays in the data section
        array0 = t.array([-3,-2,-1,0,1,2,3])
        array1 = t.array([-3,2,-1,0,3,2,1])
        # load array addresses into argument registers
        t.input_array("a0",array0)
        t.input_array("a1",array1)
        # load array length into argument register
        t.input_scalar("a2",len(array0))
        # create a result array in the data section (fill values with -1)
        result = t.array([-1] * len(array0))
        # load result array address into argument register
        t.input_array("a3",result)
        # call the `zero_one_loss` function
        t.call("zero_one_loss")
        # check that the result array contains the correct output
        correct = [1,0,1,1,0,1,0]
        t.check_array(result, correct)
        t.execute()    

    @classmethod
    def tearDownClass(cls):
        print_coverage("zero_one_loss.s", verbose=False)


"""
initialize_zero
# =======================================================
# FUNCTION: Initialize a zero array with the given length
# Arguments:
#   a0 (int) size of the array

# Returns:
#   a0 (int*)  is the pointer to the zero array
# Exceptions:
# - If the length of the array is less than 1,
#   this function terminates the program with error code 36.
# - If malloc fails, this function terminates the program with exit code 26.
# =======================================================
"""


class TestInitializeZero(unittest.TestCase):
    def test_initialize_zero_standard(self):
        t = AssemblyTest(self, "../coverage-src/initialize_zero.s")
        # input the length of the desired array
        t.input_scalar("a0",5)
        # call the `initialize_zero` function
        t.call("initialize_zero")
        # check that the register a0 contains the correct array (hint: look at the check_array_pointer function in framework.py)
        t.check_array_pointer("a0",[0]*5)
        t.execute()

    # Add other test cases if neccesary
    def test_initialize_zero_length_erro(self):
        t = AssemblyTest(self, "../coverage-src/initialize_zero.s")
        # input the length of the desired array
        t.input_scalar("a0",-1)
        # call the `initialize_zero` function
        t.call("initialize_zero")
        # check that the register a0 contains the correct array (hint: look at the check_array_pointer function in framework.py)
        #t.check_array_pointer("a0",[0]*5)
        t.execute(code=36)
    def test_initialize_zero_malloc_fail(self):
        t = AssemblyTest(self, "../coverage-src/initialize_zero.s")
        t.input_scalar("a0",1234567890123)
        t.call("initialize_zero")
    #    t.check_array_pointer("a0",[0]*1000)
        # TODO here
        t.execute(code=26)



    @classmethod
    def tearDownClass(cls):
        print_coverage("initialize_zero.s", verbose=False)


if __name__ == "__main__":
    split_idx = sys.argv.index("--")
    for arg in sys.argv[split_idx + 1 :]:
        _venus_default_args.append(arg)

    check_hashes()

    unittest.main(argv=sys.argv[:split_idx])
