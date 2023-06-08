program bob_test_main
   use TesterMain
   use bob

   implicit none


   ! Test 1: stating something
   call assert_equal("Whatever.", hey("Tom-ay-to, tom-aaaah-to."), "stating something")

   ! Test 2: shouting
   call assert_equal("Whoa, chill out!", hey("WATCH OUT!"), "shouting")

   ! Test 3: shouting gibberish
   call assert_equal("Whoa, chill out!", hey("FCECDFCAAB"), "shouting gibberish")

   ! Test 4: asking a question
   call assert_equal("Sure.", hey("Does this cryogenic chamber make me look fat?"), "asking a question")

   ! Test 5: asking a numeric question
   call assert_equal("Sure.", hey("You are, what, like 15?"), "asking a numeric question")

   ! Test 6: asking gibberish
   call assert_equal("Sure.", hey("fffbbcbeab?"), "asking gibberish")

   ! Test 7: talking forcefully
   call assert_equal("Whatever.", hey("Let's go make out behind the gym!"), "talking forcefully")

   ! Test 8: using acronyms in regular speech
   call assert_equal("Whatever.", hey("It's OK if you don't want to go to the DMV."), "using acronyms in regular speech")

   ! Test 9: forceful question
   call assert_equal("Calm down, I know what I'm doing!", hey("WHAT THE HELL WERE YOU THINKING?"), "forceful question")

   ! Test 10: shouting numbers
   call assert_equal("Whoa, chill out!", hey("1, 2, 3 GO!"), "shouting numbers")

   ! Test 11: no letters
   call assert_equal("Whatever.", hey("1, 2, 3"), "no letters")

   ! Test 12: question with no letters
   call assert_equal("Sure.", hey("4?"), "question with no letters")

   ! Test 13: shouting with special characters
   call assert_equal("Whoa, chill out!", hey("ZOMG THE %^*@#$(*^ ZOMBIES ARE COMING!!11!!1!"), "shouting with special characters")

   ! Test 14: shouting with no exclamation mark
   call assert_equal("Whoa, chill out!", hey("I HATE THE DMV"), "shouting with no exclamation mark")

   ! Test 15: statement containing question mark
   call assert_equal("Whatever.", hey("Ending with ? means a question."), "statement containing question mark")

   ! Test 16: non-letters with question
   call assert_equal("Sure.", hey(":) ?"), "non-letters with question")

   ! Test 17: prattling on
   call assert_equal("Sure.", hey("Wait! Hang on. Are you going to be OK?"), "prattling on")

   ! Test 18: silence
   call assert_equal("Fine. Be that way!", hey(""), "silence")

   ! Test 19: prolonged silence
   call assert_equal("Fine. Be that way!", hey("          "), "prolonged silence")

   ! Test 20: alternate silence
   !call assert_equal("Fine. Be that way!", hey("										"), "alternate silence")
   ! Test 21: multiple line question
   call assert_equal("Whatever.", hey(""// &
   & "Does this cryogenic chamber make me look fat?"// &
   & "No."), "multiple line question")
   ! Test 22: starting with whitespace
   call assert_equal("Whatever.", hey("         hmmmmmmm..."), "starting with whitespace")

   ! Test 23: ending with whitespace
   call assert_equal("Sure.", hey("Okay if like my  spacebar  quite a bit?   "), "ending with whitespace")

   ! Test 24: other whitespace
   !call assert_equal("Fine. Be that way!", hey(""// &
   !  & "
   !	"), "other whitespace")
   ! Test 25: non-question ending with whitespace
   call assert_equal("Whatever.", hey("This is a statement ending with whitespace      "), "non-question ending with whitespace")

   call test_report()

end program

