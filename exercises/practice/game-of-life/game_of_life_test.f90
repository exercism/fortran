! These tests are auto-generated with test data from:
! https://github.com/exercism/problem-specifications/blob/main/exercises/game-of-life/canonical-data.json
! File last updated on 2026-10-30T19:34:37+00:00

program game_of_life_test_main
  use TesterMain
  use game_of_life

  implicit none

  ! Test 1: empty matrix
  call assert_equal(reshape([integer ::], [0, 0], order=[2, 1]),&
    tick(reshape([integer ::], [0, 0], order=[2, 1])),&
    "empty matrix")

  ! Test 2: live cells with zero live neighbors die
  call assert_equal(reshape([integer :: 0, 0, 0, 0, 0, 0, 0, 0, 0], [3, 3], order=[2, 1]),&
    tick(reshape([integer :: 0, 0, 0, 0, 1, 0, 0, 0, 0], [3, 3], order=[2, 1])),&
    "live cells with zero live neighbors die")

  ! Test 3: live cells with only one live neighbor die
  call assert_equal(reshape([integer :: 0, 0, 0, 0, 0, 0, 0, 0, 0], [3, 3], order=[2, 1]),&
    tick(reshape([integer :: 0, 0, 0, 0, 1, 0, 0, 1, 0], [3, 3], order=[2, 1])),&
    "live cells with only one live neighbor die")

  ! Test 4: live cells with two live neighbors stay alive
  call assert_equal(reshape([integer :: 0, 0, 0, 1, 0, 1, 0, 0, 0], [3, 3], order=[2, 1]),&
    tick(reshape([integer :: 1, 0, 1, 1, 0, 1, 1, 0, 1], [3, 3], order=[2, 1])),&
    "live cells with two live neighbors stay alive")

  ! Test 5: live cells with three live neighbors stay alive
  call assert_equal(reshape([integer :: 0, 0, 0, 1, 0, 0, 1, 1, 0], [3, 3], order=[2, 1]),&
    tick(reshape([integer :: 0, 1, 0, 1, 0, 0, 1, 1, 0], [3, 3], order=[2, 1])),&
    "live cells with three live neighbors stay alive")

  ! Test 6: dead cells with three live neighbors become alive
  call assert_equal(reshape([integer :: 0, 0, 0, 1, 1, 0, 0, 0, 0], [3, 3], order=[2, 1]),&
    tick(reshape([integer :: 1, 1, 0, 0, 0, 0, 1, 0, 0], [3, 3], order=[2, 1])),&
    "dead cells with three live neighbors become alive")

  ! Test 7: live cells with four or more neighbors die
  call assert_equal(reshape([integer :: 1, 0, 1, 0, 0, 0, 1, 0, 1], [3, 3], order=[2, 1]),&
    tick(reshape([integer :: 1, 1, 1, 1, 1, 1, 1, 1, 1], [3, 3], order=[2, 1])),&
    "live cells with four or more neighbors die")

  ! Test 8: bigger matrix
  call assert_equal(reshape([integer :: &
      1, 1, 0, 1, 1, 0, 0, 0, &
      0, 0, 0, 0, 0, 1, 1, 0, &
      1, 0, 1, 1, 1, 1, 0, 1, &
      1, 0, 0, 0, 0, 0, 0, 1, &
      1, 1, 0, 0, 1, 0, 0, 1, &
      1, 1, 0, 1, 0, 0, 0, 1, &
      1, 0, 0, 0, 0, 0, 0, 0, &
      0, 0, 0, 0, 0, 0, 1, 1], [8, 8], order=[2, 1]),&
    tick(reshape([integer :: &
      1, 1, 0, 1, 1, 0, 0, 0, &
      1, 0, 1, 1, 0, 0, 0, 0, &
      1, 1, 1, 0, 0, 1, 1, 1, &
      0, 0, 0, 0, 0, 1, 1, 0, &
      1, 0, 0, 0, 1, 1, 0, 0, &
      1, 1, 0, 0, 0, 1, 1, 1, &
      0, 0, 1, 0, 1, 0, 0, 1, &
      1, 0, 0, 0, 0, 0, 1, 1], [8, 8], order=[2, 1])),&
    "bigger matrix")

  call test_report()

end program
