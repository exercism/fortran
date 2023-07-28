! The tests were created from https://github.com/exercism/problem-specifications/blob/main/exercises/sum-of-multiples/canonical-data.json

program sum_of_multiples_test_main
  use TesterMain
  use sum_of_multiples
  implicit none

  ! Test 1: no multiples within limit
  call assert_equal(0, sum_multiples([3, 5], 1), &
    "no multiples within limit")

  ! Test 2: one factor has multiples within limit
  call assert_equal(3, sum_multiples([3, 5], 4), &
    "one factor has multiples within limit")

  ! Test 3: more than one multiple within limit
  call assert_equal(9, sum_multiples([3], 7), &
    "more than one multiple within limit")

  ! Test 4: more than one factor with multiples within limit
  call assert_equal(23, sum_multiples([3, 5], 10), &
    "more than one factor with multiples within limit")

  ! Test 5: each multiple is only counted once
  call assert_equal(2318, sum_multiples([3, 5], 100), &
    "each multiple is only counted once")

  ! Test 6: a much larger limit
  call assert_equal(233168, sum_multiples([3, 5], 1000), &
    "a much larger limit")

  ! Test 7: three factors
  call assert_equal(51, sum_multiples([7, 13, 17], 20), &
    "three factors")

  ! Test 8: factors not relatively prime
  call assert_equal(30, sum_multiples([4, 6], 15), &
    "factors not relatively prime")

  ! Test 9: some pairs of factors relatively prime and some not
  call assert_equal(4419, sum_multiples([5, 6, 8], 150), &
    "some pairs of factors relatively prime and some not")

  ! Test 10: one factor is a multiple of another
  call assert_equal(275, sum_multiples([5, 25], 51), &
    "one factor is a multiple of another")

  ! Test 11: much larger factors
  call assert_equal(2203160, sum_multiples([43, 47], 10000), &
    "much larger factors")

  ! Test 12: all numbers are multiples of 1
  call assert_equal(4950, sum_multiples([1], 100), &
    "all numbers are multiples of 1")

  ! Test 13: no factors means an empty sum
  call assert_equal(0, sum_multiples([integer::], 10000), &
    "no factors means an empty sum")

  ! Test 14: the only multiple of 0 is 0
  call assert_equal(0, sum_multiples([0], 1), &
    "the only multiple of 0 is 0")

  ! Test 15: the factor 0 does not affect the sum of multiples of other factors
  call assert_equal(3, sum_multiples([3, 0], 4), &
    "the factor 0 does not affect the sum of multiples of other factors")

  ! Test 16: solutions using include-exclude must extend to cardinality greater than 3
  call assert_equal(39614537, sum_multiples([2, 3, 5, 7, 11], 10000), &
    "solutions using include-exclude must extend to cardinality greater than 3")

  call test_report()

end program
