! The tests were created from https://github.com/exercism/problem-specifications/blob/main/exercises/eliuds-eggs/canonical-data.json

program eliuds_eggs_test_main
  use TesterMain
  use eliuds_eggs

  implicit none

  ! Test 1: 0 eggs
  call assert_equal(0, eggCount(0), "0 eggs")

  ! Test 2: 1 egg
  call assert_equal(1, eggCount(16), "1 egg")

  ! Test 3: 4 eggs
  call assert_equal(4, eggCount(89), "4 eggs")

  ! Test 4: 13 eggs
  call assert_equal(13, eggCount(2000000000), "13 eggs")

  call test_report()

end program
