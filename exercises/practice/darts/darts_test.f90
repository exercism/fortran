! The tests were created from https://github.com/exercism/problem-specifications/blob/main/exercises/darts/canonical-data.json

program darts_test_main
  use TesterMain
  use darts
  implicit none

  ! Test 1: Missed target
  call assert_equal(0, score(-9.0, 9.0), "Missed target")

  ! Test 2: On the outer circle
  call assert_equal(1, score(0.0, 10.0), "On the outer circle")

  ! Test 3: On the middle circle
  call assert_equal(5, score(-5.0, 0.0), "On the middle circle")

  ! Test 4: On the inner circle
  call assert_equal(10, score(0.0, -1.0), "On the inner circle")

  ! Test 5: Exactly on center
  call assert_equal(10, score(0.0, 0.0), "Exactly on center")

  ! Test 6: Near the center
  call assert_equal(10, score(-0.1, -0.1), "Near the center")

  ! Test 7: Just within the inner circle
  call assert_equal(10, score(0.7, 0.7), "Just within the inner circle")

  ! Test 8: Just outside the inner circle
  call assert_equal(5, score(0.8, -0.8), "Just outside the inner circle")

  ! Test 9: Just within the middle circle
  call assert_equal(5, score(-3.5, 3.5), "Just within the middle circle")

  ! Test 10: Just outside the middle circle
  call assert_equal(1, score(-3.6, -3.6), "Just outside the middle circle")

  ! Test 11: Just within the outer circle
  call assert_equal(1, score(-7.0, 7.0), "Just within the outer circle")

  ! Test 12: Just outside the outer circle
  call assert_equal(0, score(7.1, -7.1), "Just outside the outer circle")

  ! Test 13: Asymmetric position between the inner and middle circles
  call assert_equal(5, score(0.5, -4.0), "Asymmetric position between the inner and middle circles")

  call test_report()

end program
