! These tests are auto-generated with test data from:
! https://github.com/exercism/problem-specifications/blob/main/exercises/prime-factors/canonical-data.json
! File last updated on 2026-10-26T22:44:27+00:00

program prime_factors_test_main
  use, intrinsic :: iso_fortran_env, only: int64
  use TesterMain
  use prime_factors

  implicit none

  ! Test 1: no factors
  call assert_equal([integer(int64) :: ], factors(1_int64), "no factors")

  ! Test 2: prime number
  call assert_equal([integer(int64) :: 2], factors(2_int64), "prime number")

  ! Test 3: another prime number
  call assert_equal([integer(int64) :: 3], factors(3_int64), "another prime number")

  ! Test 4: square of a prime
  call assert_equal([integer(int64) :: 3, 3], factors(9_int64), "square of a prime")

  ! Test 5: product of first prime
  call assert_equal([integer(int64) :: 2, 2], factors(4_int64), "product of first prime")

  ! Test 6: cube of a prime
  call assert_equal([integer(int64) :: 2, 2, 2], factors(8_int64), "cube of a prime")

  ! Test 7: product of second prime
  call assert_equal([integer(int64) :: 3, 3, 3], factors(27_int64), "product of second prime")

  ! Test 8: product of third prime
  call assert_equal([integer(int64) :: 5, 5, 5, 5], factors(625_int64), "product of third prime")

  ! Test 9: product of first and second prime
  call assert_equal([integer(int64) :: 2, 3], factors(6_int64), "product of first and second prime")

  ! Test 10: product of primes and non-primes
  call assert_equal([integer(int64) :: 2, 2, 3], factors(12_int64), "product of primes and non-primes")

  ! Test 11: product of primes
  call assert_equal([integer(int64) :: 5, 17, 23, 461], factors(901255_int64), "product of primes")

  ! Test 12: factors include a large prime
  call assert_equal([integer(int64) :: 11, 9539, 894119], factors(93819012551_int64), "factors include a large prime")

  call test_report()

end program
