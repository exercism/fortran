! The tests were created from https://github.com/exercism/problem-specifications/blob/main/exercises/difference-of-squares/canonical-data.json

program difference_of_squares_test_main
   use TesterMain
   use difference_of_squares

   implicit none

   ! Test 1: square of sum 1
   call assert_equal(1, square_of_sum(1), "square of sum 1")

   ! Test 2: square of sum 5
   call assert_equal(225, square_of_sum(5), "square of sum 5")

   ! Test 3: square of sum 100
   call assert_equal(25502500, square_of_sum(100), "square of sum 100")

   ! Test 4: sum of squares 1
   call assert_equal(1, sum_of_squares(1), "sum of squares 1")

   ! Test 5: sum of squares 5
   call assert_equal(55, sum_of_squares(5), "sum of squares 5")

   ! Test 6: sum of squares 100
   call assert_equal(338350, sum_of_squares(100), "sum of squares 100")

   ! Test 7: difference of squares 1
   call assert_equal(0, difference(1), "difference of squares 1")

   ! Test 8: difference of squares 5
   call assert_equal(170, difference(5), "difference of squares 5")

   ! Test 9: difference of squares 100
   call assert_equal(25164150, difference(100), "difference of squares 100")

   call test_report()

end program
