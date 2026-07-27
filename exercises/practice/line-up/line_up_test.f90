! The tests were created from https://github.com/exercism/problem-specifications/blob/main/exercises/line-up/canonical-data.json

program line_up_test_main
  use TesterMain
  use line_up

  implicit none

  ! Test 1: format smallest non-exceptional ordinal numeral 4
  call assert_equal("Gianna, you are the 4th customer we serve today. Thank you!", &
      lineUp("Gianna", 4), &
      "format smallest non-exceptional ordinal numeral 4")

  ! Test 2: format greatest single digit non-exceptional ordinal numeral 9
  call assert_equal("Maarten, you are the 9th customer we serve today. Thank you!", &
      lineUp("Maarten", 9), &
      "format greatest single digit non-exceptional ordinal numeral 9")

  ! Test 3: format non-exceptional ordinal numeral 5
  call assert_equal("Petronila, you are the 5th customer we serve today. Thank you!", &
      lineUp("Petronila", 5), &
      "format non-exceptional ordinal numeral 5")

  ! Test 4: format non-exceptional ordinal numeral 6
  call assert_equal("Attakullakulla, you are the 6th customer we serve today. Thank you!", &
      lineUp("Attakullakulla", 6), &
      "format non-exceptional ordinal numeral 6")

  ! Test 5: format non-exceptional ordinal numeral 7
  call assert_equal("Kate, you are the 7th customer we serve today. Thank you!", &
      lineUp("Kate", 7), &
      "format non-exceptional ordinal numeral 7")

  ! Test 6: format non-exceptional ordinal numeral 8
  call assert_equal("Maximiliano, you are the 8th customer we serve today. Thank you!", &
      lineUp("Maximiliano", 8), &
      "format non-exceptional ordinal numeral 8")

  ! Test 7: format exceptional ordinal numeral 1
  call assert_equal("Mary, you are the 1st customer we serve today. Thank you!", &
      lineUp("Mary", 1), &
      "format exceptional ordinal numeral 1")

  ! Test 8: format exceptional ordinal numeral 2
  call assert_equal("Haruto, you are the 2nd customer we serve today. Thank you!", &
      lineUp("Haruto", 2), &
      "format exceptional ordinal numeral 2")

  ! Test 9: format exceptional ordinal numeral 3
  call assert_equal("Henriette, you are the 3rd customer we serve today. Thank you!", &
      lineUp("Henriette", 3), &
      "format exceptional ordinal numeral 3")

  ! Test 10: format smallest two digit non-exceptional ordinal numeral 10
  call assert_equal("Alvarez, you are the 10th customer we serve today. Thank you!", &
      lineUp("Alvarez", 10), &
      "format smallest two digit non-exceptional ordinal numeral 10")

  ! Test 11: format non-exceptional ordinal numeral 11
  call assert_equal("Jacqueline, you are the 11th customer we serve today. Thank you!", &
      lineUp("Jacqueline", 11), &
      "format non-exceptional ordinal numeral 11")

  ! Test 12: format non-exceptional ordinal numeral 12
  call assert_equal("Juan, you are the 12th customer we serve today. Thank you!", &
      lineUp("Juan", 12), &
      "format non-exceptional ordinal numeral 12")

  ! Test 13: format non-exceptional ordinal numeral 13
  call assert_equal("Patricia, you are the 13th customer we serve today. Thank you!", &
      lineUp("Patricia", 13), &
      "format non-exceptional ordinal numeral 13")

  ! Test 14: format exceptional ordinal numeral 21
  call assert_equal("Washi, you are the 21st customer we serve today. Thank you!", &
      lineUp("Washi", 21), &
      "format exceptional ordinal numeral 21")

  ! Test 15: format exceptional ordinal numeral 62
  call assert_equal("Nayra, you are the 62nd customer we serve today. Thank you!", &
      lineUp("Nayra", 62), &
      "format exceptional ordinal numeral 62")

  ! Test 16: format exceptional ordinal numeral 100
  call assert_equal("John, you are the 100th customer we serve today. Thank you!", &
      lineUp("John", 100), &
      "format exceptional ordinal numeral 100")

  ! Test 17: format exceptional ordinal numeral 101
  call assert_equal("Zeinab, you are the 101st customer we serve today. Thank you!", &
      lineUp("Zeinab", 101), &
      "format exceptional ordinal numeral 101")

  ! Test 18: format non-exceptional ordinal numeral 112
  call assert_equal("Knud, you are the 112th customer we serve today. Thank you!", &
      lineUp("Knud", 112), &
      "format non-exceptional ordinal numeral 112")

  ! Test 19: format exceptional ordinal numeral 123
  call assert_equal("Yma, you are the 123rd customer we serve today. Thank you!", &
      lineUp("Yma", 123), &
      "format exceptional ordinal numeral 123")

  call test_report()

end program
