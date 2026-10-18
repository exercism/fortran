! These tests are auto-generated with test data from:
! https://github.com/exercism/problem-specifications/blob/main/exercises/all-your-base/canonical-data.json
! File last updated on 2026-10-18T16:09:21+00:00

program all_your_base_test_main
  use TesterMain
  use all_your_base

  implicit none

  ! Test 1: single bit one to decimal
  call assert_equal([1], rebase([1], 2, 10), "single bit one to decimal")

  ! Test 2: binary to single decimal
  call assert_equal([5], rebase([1, 0, 1], 2, 10), "binary to single decimal")

  ! Test 3: single decimal to binary
  call assert_equal([1, 0, 1], rebase([5], 10, 2), "single decimal to binary")

  ! Test 4: binary to multiple decimal
  call assert_equal([4, 2], rebase([1, 0, 1, 0, 1, 0], 2, 10), "binary to multiple decimal")

  ! Test 5: decimal to binary
  call assert_equal([1, 0, 1, 0, 1, 0], rebase([4, 2], 10, 2), "decimal to binary")

  ! Test 6: trinary to hexadecimal
  call assert_equal([2, 10], rebase([1, 1, 2, 0], 3, 16), "trinary to hexadecimal")

  ! Test 7: hexadecimal to trinary
  call assert_equal([1, 1, 2, 0], rebase([2, 10], 16, 3), "hexadecimal to trinary")

  ! Test 8: 15-bit integer
  call assert_equal([6, 10, 45], rebase([3, 46, 60], 97, 73), "15-bit integer")

  ! Test 9: empty list
  call assert_equal([0], rebase([integer ::], 2, 10), "empty list")

  ! Test 10: single zero
  call assert_equal([0], rebase([0], 10, 2), "single zero")

  ! Test 11: multiple zeros
  call assert_equal([0], rebase([0, 0, 0], 10, 2), "multiple zeros")

  ! Test 12: leading zeros
  call assert_equal([4, 2], rebase([0, 6, 0], 7, 10), "leading zeros")

  ! Test 13: input base is one
  call assert_equal([-1], rebase([0], 1, 10), "input base is one")

  ! Test 14: input base is zero
  call assert_equal([-1], rebase([integer ::], 0, 10), "input base is zero")

  ! Test 15: input base is negative
  call assert_equal([-1], rebase([1], -2, 10), "input base is negative")

  ! Test 16: negative digit
  call assert_equal([-1], rebase([1, -1, 1, 0, 1, 0], 2, 10), "negative digit")

  ! Test 17: invalid positive digit
  call assert_equal([-1], rebase([1, 2, 1, 0, 1, 0], 2, 10), "invalid positive digit")

  ! Test 18: output base is one
  call assert_equal([-1], rebase([1, 0, 1, 0, 1, 0], 2, 1), "output base is one")

  ! Test 19: output base is zero
  call assert_equal([-1], rebase([7], 10, 0), "output base is zero")

  ! Test 20: output base is negative
  call assert_equal([-1], rebase([1], 2, -7), "output base is negative")

  ! Test 21: both bases are negative
  call assert_equal([-1], rebase([1], -2, -7), "both bases are negative")

  call test_report()

end program
