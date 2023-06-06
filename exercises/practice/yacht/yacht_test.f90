program yacht_test_main
   use TesterMain
   use yacht

   implicit none

   ! Test 1: Yacht
   call assert_equal(50, score([5, 5, 5, 5, 5], "yacht"), "Yacht")

   ! Test 2: Not Yacht
   call assert_equal(0, score([1, 3, 3, 2, 5], "yacht"), "Not Yacht")

   ! Test 3: Ones
   call assert_equal(3, score([1, 1, 1, 3, 5], "ones"), "Ones")

   ! Test 4: Ones, out of order
   call assert_equal(3, score([3, 1, 1, 5, 1], "ones"), "Ones, out of order")

   ! Test 5: No ones
   call assert_equal(0, score([4, 3, 6, 5, 5], "ones"), "No ones")

   ! Test 6: Twos
   call assert_equal(2, score([2, 3, 4, 5, 6], "twos"), "Twos")

   ! Test 7: Fours
   call assert_equal(8, score([1, 4, 1, 4, 1], "fours"), "Fours")

   ! Test 8: Yacht counted as threes
   call assert_equal(15, score([3, 3, 3, 3, 3], "threes"), "Yacht counted as threes")

   ! Test 9: Yacht of 3s counted as fives
   call assert_equal(0, score([3, 3, 3, 3, 3], "fives"), "Yacht of 3s counted as fives")

   ! Test 10: Sixes
   call assert_equal(6, score([2, 3, 4, 5, 6], "sixes"), "Sixes")

   ! Test 11: Full house two small, three big
   call assert_equal(16, score([2, 2, 4, 4, 4], "full house"), "Full house two small, three big")

   ! Test 12: Full house three small, two big
   call assert_equal(19, score([5, 3, 3, 5, 3], "full house"), "Full house three small, two big")

   ! Test 13: Two pair is not a full house
   call assert_equal(0, score([2, 2, 4, 4, 5], "full house"), "Two pair is not a full house")

   ! Test 14: Four of a kind is not a full house
   call assert_equal(0, score([1, 4, 4, 4, 4], "full house"), "Four of a kind is not a full house")

   ! Test 15: Yacht is not a full house
   call assert_equal(0, score([2, 2, 2, 2, 2], "full house"), "Yacht is not a full house")

   ! Test 16: Four of a Kind
   call assert_equal(24, score([6, 6, 4, 6, 6], "four of a kind"), "Four of a Kind")

   ! Test 17: Yacht can be scored as Four of a Kind
   call assert_equal(12, score([3, 3, 3, 3, 3], "four of a kind"), "Yacht can be scored as Four of a Kind")

   ! Test 18: Full house is not Four of a Kind
   call assert_equal(0, score([3, 3, 3, 5, 5], "four of a kind"), "Full house is not Four of a Kind")

   ! Test 19: Little Straight
   call assert_equal(30, score([3, 5, 4, 1, 2], "little straight"), "Little Straight")

   ! Test 20: Little Straight as Big Straight
   call assert_equal(0, score([1, 2, 3, 4, 5], "big straight"), "Little Straight as Big Straight")

   ! Test 21: Four in order but not a little straight
   call assert_equal(0, score([1, 1, 2, 3, 4], "little straight"), "Four in order but not a little straight")

   ! Test 22: No pairs but not a little straight
   call assert_equal(0, score([1, 2, 3, 4, 6], "little straight"), "No pairs but not a little straight")

   ! Test 23: Minimum is 1, maximum is 5, but not a little straight
   call assert_equal(0, score([1, 1, 3, 4, 5], "little straight"), "Minimum is 1, maximum is 5, but not a little straight")

   ! Test 24: Big Straight
   call assert_equal(30, score([4, 6, 2, 5, 3], "big straight"), "Big Straight")

   ! Test 25: Big Straight as little straight
   call assert_equal(0, score([6, 5, 4, 3, 2], "little straight"), "Big Straight as little straight")

   ! Test 26: No pairs but not a big straight
   call assert_equal(0, score([6, 5, 4, 3, 1], "big straight"), "No pairs but not a big straight")

   ! Test 27: Choice
   call assert_equal(23, score([3, 3, 5, 6, 6], "choice"), "Choice")

   ! Test 28: Yacht as choice
   call assert_equal(10, score([2, 2, 2, 2, 2], "choice"), "Yacht as choice")

   call test_report()

end program

