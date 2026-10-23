! These tests are auto-generated with test data from:
! https://github.com/exercism/problem-specifications/blob/main/exercises/two-fer/canonical-data.json
! File last updated on 2026-10-17T01:05:22+00:00

program two_fer_test_main
  use TesterMain
  use two_fer

  implicit none

  ! Test 1: no name given
  call assert_equal("One for you, one for me.", twoFer(), "no name given")

  ! Test 2: a name given
  call assert_equal("One for Alice, one for me.", twoFer("Alice"), "a name given")

  ! Test 3: another name given
  call assert_equal("One for Bob, one for me.", twoFer("Bob"), "another name given")

  call test_report()

end program
