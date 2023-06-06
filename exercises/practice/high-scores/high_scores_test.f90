program high_scores_test_main
   use TesterMain
   use high_scores

   implicit none

   ! Test 1: List of scores
   call assert_equal([30, 50, 20, 70], scores([30, 50, 20, 70]), "List of scores")

   ! Test 2: Latest score
   call assert_equal(30, latest([100, 0, 90, 30]), "Latest score")

   ! Test 3: Personal best
   call assert_equal(100, personalBest([40, 100, 70]), "Personal best")

   ! Test 4: Personal top three from a list of scores
   call assert_equal([100, 90, 70], personalTopThree( &
   & [10, 30, 90, 30, 100, 20, 10, 0, 30, 40, 40, 70, 70]), &
   & "Personal top three from a list of scores")
   ! Test 5: Personal top highest to lowest
   call assert_equal([30, 20, 10], personalTopThree([20, 10, 30]), &
   & "Personal top highest to lowest")
   ! Test 6: Personal top when there is a tie
   call assert_equal([40, 40, 30], personalTopThree([40, 20, 40, 30]), &
   & "Personal top when there is a tie")
   ! Test 7: Personal top when there are less than 3
   call assert_equal([70, 30, 0], personalTopThree([30, 70]), &
   & "Personal top when there are less than 3")
   ! Test 8: Personal top when there is only one
   call assert_equal([40, 0, 0], personalTopThree([40]), &
   & "Personal top when there is only one")

   call test_report()

end program

