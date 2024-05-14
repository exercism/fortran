program binary_search_test_main
  use TesterMain
  use binary_search
  implicit none

  ! Test 1: finds a value in an array with one element
  call assert_equal(1, find([6], 6), "finds a value in an array with one element")

  ! Test 2: finds a value in the middle of an array
  call assert_equal(4, find([1, 3, 4, 6, 8, 9, 11], 6), "finds a value in the middle of an array")

  ! Test 3: finds a value at the beginning of an array
  call assert_equal(1, find([1, 3, 4, 6, 8, 9, 11], 1), "finds a value at the beginning of an array")

  ! Test 4: finds a value at the end of an array
  call assert_equal(7, find([1, 3, 4, 6, 8, 9, 11], 11), "finds a value at the end of an array")

  ! Test 5: finds a value in an array of odd length
  call assert_equal(10, find([1, 3, 5, 8, 13, 21, 34, 55, 89, 144, 233, 377, 634], 144), "finds a value in an array of odd length")

  ! Test 6: finds a value in an array of even length
  call assert_equal(6, find([1, 3, 5, 8, 13, 21, 34, 55, 89, 144, 233, 377], 21), "finds a value in an array of even length")

  ! Test 7: identifies that a value is not included in the array
  ! ERROR: value not in array
  call assert_equal(-1, find([1, 3, 4, 6, 8, 9, 11], 7), "identifies that a value is not included in the array")

  ! Test 8: a value smaller than the array's smallest value is not found
  ! ERROR: value not in array
  call assert_equal(-1, find([1, 3, 4, 6, 8, 9, 11], 0), "a value smaller than the array's smallest value is not found")

  ! Test 9: a value larger than the array's largest value is not found
  ! ERROR: value not in array
  call assert_equal(-1, find([1, 3, 4, 6, 8, 9, 11], 13), "a value larger than the array's largest value is not found")

  ! Test 10: nothing is found in an empty array
  ! ERROR: value not in array
  call assert_equal(-1, find([integer ::], 1), "nothing is found in an empty array")

  ! Test 11: nothing is found when the left and right bounds cross
  ! ERROR: value not in array
  call assert_equal(-1, find([1, 2], 0), "nothing is found when the left and right bounds cross")

  call test_report()

end program

