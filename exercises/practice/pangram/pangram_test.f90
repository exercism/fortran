program pangram_test_main
   use TesterMain
   use pangram

   implicit none

   ! Test 1: empty sentence
   call assert_equal(.false., is_pangram(""), "empty sentence")

   ! Test 2: perfect lower case
   call assert_equal(.true., is_pangram("abcdefghijklmnopqrstuvwxyz"), "perfect lower case")

   ! Test 3: only lower case
   call assert_equal(.true., is_pangram("the quick brown fox jumps over the lazy dog"), "only lower case")

   ! Test 4: missing the letter 'x'
   call assert_equal(.false., is_pangram("a quick movement of the enemy will jeopardize five gunboats"), "missing the letter 'x'")

   ! Test 5: missing the letter 'h'
   call assert_equal(.false., is_pangram("five boxing wizards jump quickly at it"), "missing the letter 'h'")

   ! Test 6: with underscores
   call assert_equal(.true., is_pangram("the_quick_brown_fox_jumps_over_the_lazy_dog"), "with underscores")

   ! Test 7: with numbers
   call assert_equal(.true., is_pangram("the 1 quick brown fox jumps over the 2 lazy dogs"), "with numbers")

   ! Test 8: missing letters replaced by numbers
   call assert_equal(.false., is_pangram("7h3 qu1ck brown fox jumps ov3r 7h3 lazy dog"), "missing letters replaced by numbers")

   ! Test 9: mixed case and punctuation
   call assert_equal(.true., is_pangram("Five quacking Zephyrs jolt my wax bed."), "mixed case and punctuation")

   ! Test 10: case insensitive
   call assert_equal(.false., is_pangram("the quick brown fox jumps over with lazy FX"), "case insensitive")

   call test_report()

end program

