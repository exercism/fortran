! The tests were created from https://github.com/exercism/problem-specifications/blob/main/exercises/largest-series-product/canonical-data.json

program largest_series_product_test_main
  use TesterMain
  use largest_series_product

  implicit none

  ! Test 1: finds the largest product if span equals length
  
  call assert_equal(18, largestProduct("29", 2), &
    "finds the largest product if span equals length")

  ! Test 2: can find the largest product of 2 with numbers in order
  
  call assert_equal(72, largestProduct("0123456789", 2), &
    "can find the largest product of 2 with numbers in order")

  ! Test 3: can find the largest product of 2
  
  call assert_equal(48, largestProduct("576802143", 2), &
    "can find the largest product of 2")

  ! Test 4: can find the largest product of 3 with numbers in order
  
  call assert_equal(504, largestProduct("0123456789", 3), &
    "can find the largest product of 3 with numbers in order")

  ! Test 5: can find the largest product of 3
  
  call assert_equal(270, largestProduct("1027839564", 3), &
    "can find the largest product of 3")

  ! Test 6: can find the largest product of 5 with numbers in order
  
  call assert_equal(15120, largestProduct("0123456789", 5), &
    "can find the largest product of 5 with numbers in order")

  ! Test 7: can get the largest product of a big number
  
  call assert_equal(23520, largestProduct("73167176531330624919225119674426574742355349194934", 6), &
    "can get the largest product of a big number")

  ! Test 8: reports zero if the only digits are zero
  
  call assert_equal(0, largestProduct("0000", 2), &
    "reports zero if the only digits are zero")

  ! Test 9: reports zero if all spans include zero
  
  call assert_equal(0, largestProduct("99099", 3), &
    "reports zero if all spans include zero")

  ! Test 10: rejects span longer than string length
  
  call assert_equal(-1, largestProduct("123", 4), &
    "rejects span longer than string length")

  ! Test 11: reports 1 for empty string and empty product (0 span)
  
  call assert_equal(1, largestProduct("", 0), &
    "reports 1 for empty string and empty product (0 span)")

  ! Test 12: reports 1 for nonempty string and empty product (0 span)
  
  call assert_equal(1, largestProduct("123", 0), &
    "reports 1 for nonempty string and empty product (0 span)")

  ! Test 13: rejects empty string and nonzero span
  
  call assert_equal(-1, largestProduct("", 1), &
    "rejects empty string and nonzero span")

  ! Test 14: rejects invalid character in digits
  
  call assert_equal(-1, largestProduct("1234a5", 2), &
    "rejects invalid character in digits")

  ! Test 15: rejects negative span
  
  call assert_equal(-1, largestProduct("12345", -1), &
    "rejects negative span")

  call test_report()

end program
