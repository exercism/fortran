program nth_prime_test_main
   use TesterMain
   use nth_prime

   implicit none

   ! Test 1: first prime
   call assert_equal(2, prime(1), "first prime")

   ! Test 2: second prime
   call assert_equal(3, prime(2), "second prime")

   ! Test 3: sixth prime
   call assert_equal(13, prime(6), "sixth prime")

   ! Test 4: big prime
   call assert_equal(104743, prime(10001), "big prime")

   ! Test 5: there is no zeroth prime
   call assert_equal(-1, prime(0), "there is no zeroth prime")

   call test_report()

end program

