
! This test was created from ..\problem-specifications\exercises\rational-numbers\canonical-data.json
!

program rational_numbers_test_main
  use TesterMain
  use rational_numbers
  implicit none

  ! Test 1: Add two positive rational numbers
  call assert_equal([7, 6], add([1, 2], [2, 3]), "Add two positive rational numbers")
  ! Test 2: Add a positive rational number and a negative rational number
  call assert_equal([-1, 6], add([1, 2], [-2, 3]), "Add a positive rational number and a negative rational number")
  ! Test 3: Add two negative rational numbers
  call assert_equal([-7, 6], add([-1, 2], [-2, 3]), "Add two negative rational numbers")
  ! Test 4: Add a rational number to its additive inverse
  call assert_equal([0, 1], add([1, 2], [-1, 2]), "Add a rational number to its additive inverse")
  ! Test 5: Subtract two positive rational numbers
  call assert_equal([-1, 6], sub([1, 2], [2, 3]), "Subtract two positive rational numbers")
  ! Test 6: Subtract a positive rational number and a negative rational number
  call assert_equal([7, 6], sub([1, 2], [-2, 3]), "Subtract a positive rational number and a negative rational number")
  ! Test 7: Subtract two negative rational numbers
  call assert_equal([1, 6], sub([-1, 2], [-2, 3]), "Subtract two negative rational numbers")
  ! Test 8: Subtract a rational number from itself
  call assert_equal([0, 1], sub([1, 2], [1, 2]), "Subtract a rational number from itself")
  ! Test 9: Multiply two positive rational numbers
  call assert_equal([1, 3], mul([1, 2], [2, 3]), "Multiply two positive rational numbers")
  ! Test 10: Multiply a negative rational number by a positive rational number
  call assert_equal([-1, 3], mul([-1, 2], [2, 3]), "Multiply a negative rational number by a positive rational number")
  ! Test 11: Multiply two negative rational numbers
  call assert_equal([1, 3], mul([-1, 2], [-2, 3]), "Multiply two negative rational numbers")
  ! Test 12: Multiply a rational number by its reciprocal
  call assert_equal([1, 1], mul([1, 2], [2, 1]), "Multiply a rational number by its reciprocal")
  ! Test 13: Multiply a rational number by 1
  call assert_equal([1, 2], mul([1, 2], [1, 1]), "Multiply a rational number by 1")
  ! Test 14: Multiply a rational number by 0
  call assert_equal([0, 1], mul([1, 2], [0, 1]), "Multiply a rational number by 0")
  ! Test 15: Divide two positive rational numbers
  call assert_equal([3, 4], div([1, 2], [2, 3]), "Divide two positive rational numbers")
  ! Test 16: Divide a positive rational number by a negative rational number
  call assert_equal([-3, 4], div([1, 2], [-2, 3]), "Divide a positive rational number by a negative rational number")
  ! Test 17: Divide two negative rational numbers
  call assert_equal([3, 4], div([-1, 2], [-2, 3]), "Divide two negative rational numbers")
  ! Test 18: Divide a rational number by 1
  call assert_equal([1, 2], div([1, 2], [1, 1]), "Divide a rational number by 1")
  ! Test 19: Absolute value of a positive rational number
  call assert_equal([1, 2], rational_abs([1, 2]), "Absolute value of a positive rational number")
  ! Test 20: Absolute value of a positive rational number with negative numerator and denominator
  call assert_equal([1, 2], rational_abs([-1, -2]), &
    & "Absolute value of a positive rational number with negative numerator and denominator")
  ! Test 21: Absolute value of a negative rational number
  call assert_equal([1, 2], rational_abs([-1, 2]), "Absolute value of a negative rational number")
  ! Test 22: Absolute value of a negative rational number with negative denominator
  call assert_equal([1, 2], rational_abs([1, -2]), &
    & "Absolute value of a negative rational number with negative denominator")
  ! Test 23: Absolute value of zero
  call assert_equal([0, 1], rational_abs([0, 1]), "Absolute value of zero")
  ! Test 24: Raise a positive rational number to a positive integer power
  call assert_equal([1, 8], rational_to_pow([1, 2], 3), &
    & "Raise a positive rational number to a positive integer power")
  ! Test 25: Raise a negative rational number to a positive integer power
  call assert_equal([-1, 8], rational_to_pow([-1, 2], 3), &
    & "Raise a negative rational number to a positive integer power")
  ! Test 26: Raise zero to an integer power
  call assert_equal([0, 1], rational_to_pow([0, 1], 5), "Raise zero to an integer power")
  ! Test 27: Raise one to an integer power
  call assert_equal([1, 1], rational_to_pow([1, 1], 4), "Raise one to an integer power")
  ! Test 28: Raise a positive rational number to the power of zero
  call assert_equal([1, 1], rational_to_pow([1, 2], 0), "Raise a positive rational number to the power of zero")
  ! Test 29: Raise a negative rational number to the power of zero
  call assert_equal([1, 1], rational_to_pow([-1, 2], 0), "Raise a negative rational number to the power of zero")
  ! Test 30: Raise a real number to a positive rational number
  call assert_equal(8.0**(4./3.), real_to_rational_pow(8., [4, 3]), &
    & "Raise a real number to a positive rational number")
  ! Test 31: Raise a real number to a negative rational number
  call assert_equal(0.3333333333333333, real_to_rational_pow(9., [-1, 2]), &
    & "Raise a real number to a negative rational number")
  ! Test 32: Raise a real number to a zero rational number
  call assert_equal(1.0, real_to_rational_pow(2., [0, 1]), "Raise a real number to a zero rational number")
  ! Test 33: Reduce a positive rational number to lowest terms
  call assert_equal([1, 2], reduce([2, 4]), "Reduce a positive rational number to lowest terms")
  ! Test 34: Reduce a negative rational number to lowest terms
  call assert_equal([-2, 3], reduce([-4, 6]), "Reduce a negative rational number to lowest terms")
  ! Test 35: Reduce a rational number with a negative denominator to lowest terms
  call assert_equal([-1, 3], reduce([3, -9]), &
    & "Reduce a rational number with a negative denominator to lowest terms")
  ! Test 36: Reduce zero to lowest terms
  call assert_equal([0, 1], reduce([0, 6]), "Reduce zero to lowest terms")
  ! Test 37: Reduce an integer to lowest terms
  call assert_equal([-2, 1], reduce([-14, 7]), "Reduce an integer to lowest terms")
  ! Test 38: Reduce one to lowest terms
  call assert_equal([1, 1], reduce([13, 13]), "Reduce one to lowest terms")

  call test_report()

end program

