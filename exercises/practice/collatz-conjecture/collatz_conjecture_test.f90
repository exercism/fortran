program collatz_conjecture_test_main
   use TesterMain
   use collatz_conjecture

   implicit none

   ! Test 1: zero steps for one
   call assert_equal(0, steps(1), "zero steps for one")

   ! Test 2: divide if even
   call assert_equal(4, steps(16), "divide if even")

   ! Test 3: even and odd steps
   call assert_equal(9, steps(12), "even and odd steps")

   ! Test 4: large number of even and odd steps
   call assert_equal(152, steps(1000000), "large number of even and odd steps")

   ! Test 5: zero is an error
   ! ERROR: Only positive numbers are allowed
   call assert_equal(-1, steps(0), "zero is an error")

   ! Test 6: negative value is an error
   ! ERROR: Only positive numbers are allowed
   call assert_equal(-1, steps(-15), "negative value is an error")

   call test_report()

end program

