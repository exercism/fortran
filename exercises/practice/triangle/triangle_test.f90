! The tests were created from https://github.com/exercism/problem-specifications/blob/main/exercises/triangle/canonical-data.json

program triangle_test_main
   use TesterMain
   use triangle

   implicit none

   ! Test 1: all sides are equal
   call assert_equal(.true., equilateral([2, 2, 2]), "all sides are equal")

   ! Test 2: any side is unequal
   call assert_equal(.false., equilateral([2, 3, 2]), "any side is unequal")

   ! Test 3: no sides are equal
   call assert_equal(.false., equilateral([5, 4, 6]), "no sides are equal")

   ! Test 4: all zero sides is not a triangle
   call assert_equal(.false., equilateral([0, 0, 0]), "all zero sides is not a triangle")

   ! Test 5: sides may be floats
   call assert_equal(.true., equilateral([0.5, 0.5, 0.5]), "sides may be floats")

   ! Test 6: last two sides are equal
   call assert_equal(.true., isosceles([3, 4, 4]), "last two sides are equal")

   ! Test 7: first two sides are equal
   call assert_equal(.true., isosceles([4, 4, 3]), "first two sides are equal")

   ! Test 8: first and last sides are equal
   call assert_equal(.true., isosceles([4, 3, 4]), "first and last sides are equal")

   ! Test 9: equilateral triangles are also isosceles
   call assert_equal(.true., isosceles([4, 4, 4]), "equilateral triangles are also isosceles")

   ! Test 10: no sides are equal
   call assert_equal(.false., isosceles([2, 3, 4]), "no sides are equal")

   ! Test 11: first triangle inequality violation
   call assert_equal(.false., isosceles([1, 1, 3]), "first triangle inequality violation")

   ! Test 12: second triangle inequality violation
   call assert_equal(.false., isosceles([1, 3, 1]), "second triangle inequality violation")

   ! Test 13: third triangle inequality violation
   call assert_equal(.false., isosceles([3, 1, 1]), "third triangle inequality violation")

   ! Test 14: sides may be floats
   call assert_equal(.true., isosceles([0.5, 0.4, 0.5]), "sides may be floats")

   ! Test 15: no sides are equal
   call assert_equal(.true., scalene([5, 4, 6]), "no sides are equal")

   ! Test 16: all sides are equal
   call assert_equal(.false., scalene([4, 4, 4]), "all sides are equal")

   ! Test 17: first and second sides are equal
   call assert_equal(.false., scalene([4, 4, 3]), "first and second sides are equal")

   ! Test 18: first and third sides are equal
   call assert_equal(.false., scalene([3, 4, 3]), "first and third sides are equal")

   ! Test 19: second and third sides are equal
   call assert_equal(.false., scalene([4, 3, 3]), "second and third sides are equal")

   ! Test 20: may not violate triangle inequality
   call assert_equal(.false., scalene([7, 3, 2]), "may not violate triangle inequality")

   ! Test 21: sides may be floats
   call assert_equal(.true., scalene([0.5, 0.4, 0.6]), "sides may be floats")

   call test_report()

end program
