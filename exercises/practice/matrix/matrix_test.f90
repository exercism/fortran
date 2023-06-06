program matrix_test_main

   use TesterMain
   use matrix

   implicit none

   ! Test 1: extract row from one number matrix
   !!call assert_equal_int_arr(1, row(1, 1), "extract row from one number matrix")
   ! Test 2: can extract row
   call assert_equal((/3, 4/), row( (/"1, 2", "3, 4"/), (/ 2, 2 /), 2), "can extract row")

   ! Test 3: extract row where numbers have different widths
   call assert_equal((/10, 20/), row( (/"1, 2  ", "10, 20"/), (/ 2, 2 /), 2), &
   & "extract row where numbers have different widths")
   ! Test 4: can extract row from non-square matrix with no corresponding column
   call assert_equal((/8, 7, 6/), row( &
   & (/"1, 2, 3", &
   &   "4, 5, 6", &
   &   "7, 8, 9", &
   &   "8, 7, 6"/), (/ 4, 3 /), 4), &
   &  "can extract row from non-square matrix with no corresponding column")
   ! Test 5: extract column from one number matrix
   !!call assert_equal_int_arr(1, column(1, 1), "extract column from one number matrix")
   ! Test 6: can extract column
   call assert_equal((/3, 6, 9/), column( &
   & (/"1, 2, 3", &
   &   "4, 5, 6", &
   &   "7, 8, 9"/), (/3, 3/), 3), &
   & "can extract column")
   ! Test 7: can extract column from non-square matrix with no corresponding row
   call assert_equal((/4, 8, 6/), column( &
   & (/"1, 2, 3, 4", &
   &   "5, 6, 7, 8", &
   &   "9, 8, 7, 6"/), (/3,4/), 4), &
   & "can extract column from non-square matrix with no corresponding row")
   ! Test 8: extract column where numbers have different widths
   call assert_equal((/1903, 3, 479/), column( &
   &  (/"89, 1903, 3", &
   &    "18, 3, 1   ", &
   &    "9, 479, 800"/), (/3,3/), 2), &
   & "extract column where numbers have different widths")

   call test_report()

end program

