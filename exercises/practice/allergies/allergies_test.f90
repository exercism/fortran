program allergies_test_main
   use TesterMain
   use allergies

   implicit none

   ! Test 1: not allergic to anything
   call assert_equal(.false., allergicTo("eggs", 0), "not allergic to anything")

   ! Test 2: allergic only to eggs
   call assert_equal(.true., allergicTo("eggs", 1), "allergic only to eggs")

   ! Test 3: allergic to eggs and something else
   call assert_equal(.true., allergicTo("eggs", 3), "allergic to eggs and something else")

   ! Test 4: allergic to something, but not eggs
   call assert_equal(.false., allergicTo("eggs", 2), "allergic to something, but not eggs")

   ! Test 5: allergic to everything
   call assert_equal(.true., allergicTo("eggs", 255), "allergic to everything")

   ! Test 1: not allergic to anything
   call assert_equal(.false., allergicTo("peanuts", 0), "not allergic to anything")

   ! Test 2: allergic only to peanuts
   call assert_equal(.true., allergicTo("peanuts", 2), "allergic only to peanuts")

   ! Test 3: allergic to peanuts and something else
   call assert_equal(.true., allergicTo("peanuts", 7), "allergic to peanuts and something else")

   ! Test 4: allergic to something, but not peanuts
   call assert_equal(.false., allergicTo("peanuts", 5), "allergic to something, but not peanuts")

   ! Test 5: allergic to everything
   call assert_equal(.true., allergicTo("peanuts", 255), "allergic to everything")

   ! Test 1: not allergic to anything
   call assert_equal(.false., allergicTo("shellfish", 0), "not allergic to anything")

   ! Test 2: allergic only to shellfish
   call assert_equal(.true., allergicTo("shellfish", 4), "allergic only to shellfish")

   ! Test 3: allergic to shellfish and something else
   call assert_equal(.true., allergicTo("shellfish", 14), "allergic to shellfish and something else")

   ! Test 4: allergic to something, but not shellfish
   call assert_equal(.false., allergicTo("shellfish", 10), "allergic to something, but not shellfish")

   ! Test 5: allergic to everything
   call assert_equal(.true., allergicTo("shellfish", 255), "allergic to everything")

   ! Test 1: not allergic to anything
   call assert_equal(.false., allergicTo("strawberries", 0), "not allergic to anything")

   ! Test 2: allergic only to strawberries
   call assert_equal(.true., allergicTo("strawberries", 8), "allergic only to strawberries")

   ! Test 3: allergic to strawberries and something else
   call assert_equal(.true., allergicTo("strawberries", 28), "allergic to strawberries and something else")

   ! Test 4: allergic to something, but not strawberries
   call assert_equal(.false., allergicTo("strawberries", 20), "allergic to something, but not strawberries")

   ! Test 5: allergic to everything
   call assert_equal(.true., allergicTo("strawberries", 255), "allergic to everything")

   ! Test 1: not allergic to anything
   call assert_equal(.false., allergicTo("tomatoes", 0), "not allergic to anything")

   ! Test 2: allergic only to tomatoes
   call assert_equal(.true., allergicTo("tomatoes", 16), "allergic only to tomatoes")

   ! Test 3: allergic to tomatoes and something else
   call assert_equal(.true., allergicTo("tomatoes", 56), "allergic to tomatoes and something else")

   ! Test 4: allergic to something, but not tomatoes
   call assert_equal(.false., allergicTo("tomatoes", 40), "allergic to something, but not tomatoes")

   ! Test 5: allergic to everything
   call assert_equal(.true., allergicTo("tomatoes", 255), "allergic to everything")

   ! Test 1: not allergic to anything
   call assert_equal(.false., allergicTo("chocolate", 0), "not allergic to anything")

   ! Test 2: allergic only to chocolate
   call assert_equal(.true., allergicTo("chocolate", 32), "allergic only to chocolate")

   ! Test 3: allergic to chocolate and something else
   call assert_equal(.true., allergicTo("chocolate", 112), "allergic to chocolate and something else")

   ! Test 4: allergic to something, but not chocolate
   call assert_equal(.false., allergicTo("chocolate", 80), "allergic to something, but not chocolate")

   ! Test 5: allergic to everything
   call assert_equal(.true., allergicTo("chocolate", 255), "allergic to everything")

   ! Test 1: not allergic to anything
   call assert_equal(.false., allergicTo("pollen", 0), "not allergic to anything")

   ! Test 2: allergic only to pollen
   call assert_equal(.true., allergicTo("pollen", 64), "allergic only to pollen")

   ! Test 3: allergic to pollen and something else
   call assert_equal(.true., allergicTo("pollen", 224), "allergic to pollen and something else")

   ! Test 4: allergic to something, but not pollen
   call assert_equal(.false., allergicTo("pollen", 160), "allergic to something, but not pollen")

   ! Test 5: allergic to everything
   call assert_equal(.true., allergicTo("pollen", 255), "allergic to everything")

   ! Test 1: not allergic to anything
   call assert_equal(.false., allergicTo("cats", 0), "not allergic to anything")

   ! Test 2: allergic only to cats
   call assert_equal(.true., allergicTo("cats", 128), "allergic only to cats")

   ! Test 3: allergic to cats and something else
   call assert_equal(.true., allergicTo("cats", 192), "allergic to cats and something else")

   ! Test 4: allergic to something, but not cats
   call assert_equal(.false., allergicTo("cats", 64), "allergic to something, but not cats")

   ! Test 5: allergic to everything
   call assert_equal(.true., allergicTo("cats", 255), "allergic to everything")

   ! Test 1: no allergies
   call assert_equal(' ', allergicList(0), "no allergies")

   ! Test 2: just eggs
   call assert_equal('eggs', allergicList(1), "just eggs")

   ! Test 3: just peanuts
   call assert_equal('peanuts', allergicList(2), "just peanuts")

   ! Test 4: just strawberries
   call assert_equal('strawberries', allergicList(8), "just strawberries")

   ! Test 5: eggs and peanuts
   call assert_equal('eggs peanuts', allergicList(3), "eggs and peanuts")

   ! Test 6: more than eggs but not peanuts
   call assert_equal('eggs shellfish', allergicList(5), "more than eggs but not peanuts")

   ! Test 7: lots of stuff
   call assert_equal('strawberries tomatoes chocolate pollen cats', allergicList(248), "lots of stuff")

   ! Test 8: everything
   call assert_equal('eggs peanuts shellfish strawberries tomatoes chocolate pollen cats', &
   & allergicList(255), "everything")
   ! Test 9: no allergen score parts
   call assert_equal('eggs shellfish strawberries tomatoes chocolate pollen cats', &
   & allergicList(509), "no allergen score parts")

   call test_report()

end program

