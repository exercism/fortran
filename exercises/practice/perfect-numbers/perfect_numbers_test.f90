! The tests were created from https://github.com/exercism/problem-specifications/blob/main/exercises/perfect-numbers/canonical-data.json

program perfect_numbers_test_main
  use TesterMain
  use perfect_numbers
  implicit none

! Test 1: Smallest perfect number is classified correctly
  call assert_equal("perfect", classify(6), "Smallest perfect number is classified correctly")

! Test 2: Medium perfect number is classified correctly
  call assert_equal("perfect", classify(28), "Medium perfect number is classified correctly")

! Test 3: Large perfect number is classified correctly
  call assert_equal("perfect", classify(33550336), "Large perfect number is classified correctly")

! Test 4: Smallest abundant number is classified correctly
  call assert_equal("abundant", classify(12), "Smallest abundant number is classified correctly")

! Test 5: Medium abundant number is classified correctly
  call assert_equal("abundant", classify(30), "Medium abundant number is classified correctly")

! Test 6: Large abundant number is classified correctly
  call assert_equal("abundant", classify(33550335), "Large abundant number is classified correctly")

! Test 7: Perfect square abundant number is classified correctly
  call assert_equal("abundant", classify(196), "Perfect square abundant number is classified correctly")

! Test 8: Smallest prime deficient number is classified correctly
  call assert_equal("deficient", classify(2), "Smallest prime deficient number is classified correctly")

! Test 9: Smallest non-prime deficient number is classified correctly
  call assert_equal("deficient", classify(4), "Smallest non-prime deficient number is classified correctly")

! Test 10: Medium deficient number is classified correctly
  call assert_equal("deficient", classify(32), "Medium deficient number is classified correctly")

! Test 11: Large deficient number is classified correctly
  call assert_equal("deficient", classify(33550337), "Large deficient number is classified correctly")

! Test 12: Edge case (no factors other than itself) is classified correctly
  call assert_equal("deficient", classify(1), "Edge case (no factors other than itself) is classified correctly")

! Test 13: Zero is rejected (as it is not a positive integer)
  call assert_equal("ERROR", classify(0), "Zero is rejected (as it is not a positive integer)")

! Test 14: Negative integer is rejected (as it is not a positive integer)
  call assert_equal("ERROR", classify(-1), "Negative integer is rejected (as it is not a positive integer)")


  call test_report()

end program
