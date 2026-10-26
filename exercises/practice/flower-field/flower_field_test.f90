! These tests are auto-generated with test data from:
! https://github.com/exercism/problem-specifications/blob/main/exercises/flower-field/canonical-data.json
! File last updated on 2026-10-26T17:17:11+00:00

program flower_field_test_main
  use TesterMain
  use flower_field

  implicit none

  ! Test 1: no rows
  call assert_equal(reshape([character(len=1) ::], [0, 0], order=[2, 1]),&
    annotate(reshape([character(len=1) ::], [0, 0], order=[2, 1])), "no rows")

  ! Test 2: no columns
  call assert_equal(reshape([character(len=1) ::], [1, 0], order=[2, 1]),&
    annotate(reshape([character(len=1) ::], [1, 0], order=[2, 1])), "no columns")

  ! Test 3: no flowers
  call assert_equal(reshape([character(len=1) :: &
      " ", " ", " ", &
      " ", " ", " ", &
      " ", " ", " "], [3, 3], order=[2, 1]),&
    annotate(reshape([character(len=1) :: &
      " ", " ", " ", &
      " ", " ", " ", &
      " ", " ", " "], [3, 3], order=[2, 1])), "no flowers")

  ! Test 4: garden full of flowers
  call assert_equal(reshape([character(len=1) :: &
      "*", "*", "*", &
      "*", "*", "*", &
      "*", "*", "*"], [3, 3], order=[2, 1]),&
    annotate(reshape([character(len=1) :: &
      "*", "*", "*", &
      "*", "*", "*", &
      "*", "*", "*"], [3, 3], order=[2, 1])), "garden full of flowers")

  ! Test 5: flower surrounded by spaces
  call assert_equal(reshape([character(len=1) :: &
      "1", "1", "1", &
      "1", "*", "1", &
      "1", "1", "1"], [3, 3], order=[2, 1]),&
    annotate(reshape([character(len=1) :: &
      " ", " ", " ", &
      " ", "*", " ", &
      " ", " ", " "], [3, 3], order=[2, 1])), "flower surrounded by spaces")

  ! Test 6: space surrounded by flowers
  call assert_equal(reshape([character(len=1) :: &
      "*", "*", "*", &
      "*", "8", "*", &
      "*", "*", "*"], [3, 3], order=[2, 1]),&
    annotate(reshape([character(len=1) :: &
      "*", "*", "*", &
      "*", " ", "*", &
      "*", "*", "*"], [3, 3], order=[2, 1])), "space surrounded by flowers")

  ! Test 7: horizontal line
  call assert_equal(reshape([character(len=1) :: "1", "*", "2", "*", "1"], [1, 5], order=[2, 1]),&
    annotate(reshape([character(len=1) :: " ", "*", " ", "*", " "], [1, 5], order=[2, 1])), "horizontal line")

  ! Test 8: horizontal line, flowers at edges
  call assert_equal(reshape([character(len=1) :: "*", "1", " ", "1", "*"], [1, 5], order=[2, 1]),&
    annotate(reshape([character(len=1) :: "*", " ", " ", " ", "*"], [1, 5], order=[2, 1])), "horizontal line, flowers at edges")

  ! Test 9: vertical line
  call assert_equal(reshape([character(len=1) :: "1", "*", "2", "*", "1"], [5, 1], order=[2, 1]),&
    annotate(reshape([character(len=1) :: " ", "*", " ", "*", " "], [5, 1], order=[2, 1])), "vertical line")

  ! Test 10: vertical line, flowers at edges
  call assert_equal(reshape([character(len=1) :: "*", "1", " ", "1", "*"], [5, 1], order=[2, 1]),&
    annotate(reshape([character(len=1) :: "*", " ", " ", " ", "*"], [5, 1], order=[2, 1])), "vertical line, flowers at edges")

  ! Test 11: cross
  call assert_equal(reshape([character(len=1) :: &
      " ", "2", "*", "2", " ", &
      "2", "5", "*", "5", "2", &
      "*", "*", "*", "*", "*", &
      "2", "5", "*", "5", "2", &
      " ", "2", "*", "2", " "], [5, 5], order=[2, 1]),&
    annotate(reshape([character(len=1) :: &
      " ", " ", "*", " ", " ", &
      " ", " ", "*", " ", " ", &
      "*", "*", "*", "*", "*", &
      " ", " ", "*", " ", " ", &
      " ", " ", "*", " ", " "], [5, 5], order=[2, 1])), "cross")

  ! Test 12: large garden
  call assert_equal(reshape([character(len=1) :: &
      "1", "*", "2", "2", "*", "1", &
      "1", "2", "*", "3", "2", "2", &
      " ", "1", "2", "3", "*", "2", &
      "1", "1", "2", "*", "4", "*", &
      "1", "*", "2", "2", "*", "2", &
      "1", "1", "1", "1", "1", "1"], [6, 6], order=[2, 1]),&
    annotate(reshape([character(len=1) :: &
      " ", "*", " ", " ", "*", " ", &
      " ", " ", "*", " ", " ", " ", &
      " ", " ", " ", " ", "*", " ", &
      " ", " ", " ", "*", " ", "*", &
      " ", "*", " ", " ", "*", " ", &
      " ", " ", " ", " ", " ", " "], [6, 6], order=[2, 1])), "large garden")

  ! Test 13: multiple adjacent flowers
  call assert_equal(reshape([character(len=1) :: "1", "*", "*", "1"], [1, 4], order=[2, 1]),&
    annotate(reshape([character(len=1) :: " ", "*", "*", " "], [1, 4], order=[2, 1])), "multiple adjacent flowers")

  call test_report()

end program
