program acronym_test_main
   use TesterMain
   use acronym

   implicit none

   ! Test 1: basic
   call assert_equal("PNG", abbreviate("Portable Network Graphics"), "basic")

   ! Test 2: lowercase words
   call assert_equal("ROR", abbreviate("Ruby on Rails"), "lowercase words")

   ! Test 3: punctuation
   call assert_equal("FIFO", abbreviate("First In, First Out"), "punctuation")

   ! Test 4: all caps word
   call assert_equal("GIMP", abbreviate("GNU Image Manipulation Program"), "all caps word")

   ! Test 5: punctuation without whitespace
   call assert_equal("CMOS", abbreviate("Complementary metal-oxide semiconductor"), "punctuation without whitespace")

   ! Test 6: very long abbreviation
   call assert_equal("ROTFLSHTMDCOALM", abbreviate(&
   & "Rolling On The Floor Laughing So Hard That My Dogs Came Over And Licked Me"), "very long abbreviation")
   ! Test 7: consecutive delimiters
   call assert_equal("SIMUFTA", abbreviate("Something - I made up from thin air"), "consecutive delimiters")

   ! Test 8: apostrophes
   call assert_equal("HC", abbreviate("Halley's Comet"), "apostrophes")

   ! Test 9: underscore emphasis
   call assert_equal("TRNT", abbreviate("The Road _Not_ Taken"), "underscore emphasis")

   call test_report()

end program

