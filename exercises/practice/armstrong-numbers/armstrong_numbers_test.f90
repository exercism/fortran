program armstrong_numbers_test_main
   use TesterMain
   use armstrong_numbers

   implicit none

   ! Test 1: Zero is an Armstrong number
   call assert_equal(.true., isArmstrongNumber(0), "Zero is an Armstrong number")

   ! Test 2: Single digit numbers are Armstrong numbers
   call assert_equal(.true., isArmstrongNumber(5), "Single digit numbers are Armstrong numbers")

   ! Test 3: There are no 2 digit Armstrong numbers
   call assert_equal(.false., isArmstrongNumber(10), "There are no 2 digit Armstrong numbers")

   ! Test 4: Three digit number that is an Armstrong number
   call assert_equal(.true., isArmstrongNumber(153), "Three digit number that is an Armstrong number")

   ! Test 5: Three digit number that is not an Armstrong number
   call assert_equal(.false., isArmstrongNumber(100), "Three digit number that is not an Armstrong number")

   ! Test 6: Four digit number that is an Armstrong number
   call assert_equal(.true., isArmstrongNumber(9474), "Four digit number that is an Armstrong number")

   ! Test 7: Four digit number that is not an Armstrong number
   call assert_equal(.false., isArmstrongNumber(9475), "Four digit number that is not an Armstrong number")

   ! Test 8: Seven digit number that is an Armstrong number
   call assert_equal(.true., isArmstrongNumber(9926315), "Seven digit number that is an Armstrong number")

   ! Test 9: Seven digit number that is not an Armstrong number
   call assert_equal(.false., isArmstrongNumber(9926314), "Seven digit number that is not an Armstrong number")

   call test_report()

end program

