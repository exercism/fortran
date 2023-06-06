program grains_test_main
   use TesterMain
   use grains

   implicit none

   ! Test 1: grains on square 1
   call assert_equal(1.d0, square(1), "grains on square 1")

   ! Test 2: grains on square 2
   call assert_equal(2.d0, square(2), "grains on square 2")

   ! Test 3: grains on square 3
   call assert_equal(4.d0, square(3), "grains on square 3")

   ! Test 4: grains on square 4
   call assert_equal(8.d0, square(4), "grains on square 4")

   ! Test 5: grains on square 16
   call assert_equal(32768.d0, square(16), "grains on square 16")

   ! Test 6: grains on square 32
   call assert_equal(2147483648.d0, square(32), "grains on square 32")

   ! Test 7: grains on square 64
   call assert_equal(9223372036854775808.d0, square(64), "grains on square 64")

   ! Test 8: square 0 raises an exception
   ! ERROR: square must be between 1 and 64
   call assert_equal(-1.d0, square(0), "square 0 raises an exception")

   ! Test 9: negative square raises an exception
   ! ERROR: square must be between 1 and 64
   call assert_equal(-1.d0, square(-1), "negative square raises an exception")

   ! Test 10: square greater than 64 raises an exception
   ! ERROR: square must be between 1 and 64
   call assert_equal(-1.d0, square(65), "square greater than 64 raises an exception")

   ! Test 11: returns the total number of grains on the board
   call assert_equal(18446744073709551615.d0, total(), "returns the total number of grains on the board")

   call test_report()

end program

