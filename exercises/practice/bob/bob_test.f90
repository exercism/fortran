! The tests were created from https://github.com/exercism/problem-specifications/blob/main/exercises/bob/canonical-data.json

program bob_test_main
  use TesterMain
  use bob
  implicit none

  character(len=1), parameter :: CARRIAGE_RETURN = CHAR(13)
  character(len=1), parameter :: NEWLINE = CHAR(10)
  character(len=1), parameter :: TAB = CHAR(9)

! Test 1: asking a question
  call assert_equal("Sure.", &
                    hey("Does this cryogenic chamber make me look fat?"), &
                    "asking a question")

! Test 2: shouting
  call assert_equal("Whoa, chill out!", &
                    hey("WATCH OUT!"), &
                    "shouting")

! Test 3: forceful question
  call assert_equal("Calm down, I know what I'm doing!", &
                    hey("WHAT'S GOING ON?"), &
                    "forceful question")

! Test 4: silence
  call assert_equal("Fine. Be that way!", &
                    hey(""), &
                    "silence")

! Test 5: stating something
  call assert_equal("Whatever.", &
                    hey("Tom-ay-to, tom-aaaah-to."), &
                    "stating something")

! Test 6: asking a numeric question
  call assert_equal("Sure.", &
                    hey("You are, what, like 15?"), &
                    "asking a numeric question")

! Test 7: asking gibberish
  call assert_equal("Sure.", &
                    hey("fffbbcbeab?"), &
                    "asking gibberish")

! Test 8: question with no letters
  call assert_equal("Sure.", &
                    hey("4?"), &
                    "question with no letters")

! Test 9: non-letters with question
  call assert_equal("Sure.", &
                    hey(":) ?"), &
                    "non-letters with question")

! Test 10: prattling on
  call assert_equal("Sure.", &
                    hey("Wait! Hang on. Are you going to be OK?"), &
                    "prattling on")

! Test 11: ending with whitespace
  call assert_equal("Sure.", &
                    hey("Okay if like my  spacebar  quite a bit?   "), &
                    "ending with whitespace")

! Test 12: multiple line question
  call assert_equal("Sure.", &
                    hey("" // NEWLINE // "Does this cryogenic chamber make" // NEWLINE // " me look fat?"), &
                    "multiple line question")

! Test 13: shouting gibberish
  call assert_equal("Whoa, chill out!", &
                    hey("FCECDFCAAB"), &
                    "shouting gibberish")

! Test 14: shouting a statement containing a question mark
  call assert_equal("Whoa, chill out!", &
                    hey("DO LIONS EAT PEOPLE? AHHHHH."), &
                    "shouting a statement containing a question mark")

! Test 15: shouting numbers
  call assert_equal("Whoa, chill out!", &
                    hey("1, 2, 3 GO!"), &
                    "shouting numbers")

! Test 16: shouting with special characters
  call assert_equal("Whoa, chill out!", &
                    hey("ZOMG THE %^*@#$(*^ ZOMBIES ARE COMING!!11!!1!"), &
                    "shouting with special characters")

! Test 17: shouting with no exclamation mark
  call assert_equal("Whoa, chill out!", &
                    hey("I HATE THE DENTIST"), &
                    "shouting with no exclamation mark")

! Test 18: prolonged silence
  call assert_equal("Fine. Be that way!", &
                    hey("          "), &
                    "prolonged silence")

! Test 19: alternate silence
  call assert_equal("Fine. Be that way!", &
                    hey("" // TAB // TAB // TAB // TAB // TAB // TAB // TAB // TAB // TAB // TAB // ""), &
                    "alternate silence")

! Test 20: other whitespace
  call assert_equal("Fine. Be that way!", &
                    hey("" // NEWLINE // CARRIAGE_RETURN // " " // TAB // ""), &
                    "other whitespace")

! Test 21: talking forcefully
  call assert_equal("Whatever.", &
                    hey("Hi there!"), &
                    "talking forcefully")

! Test 22: using acronyms in regular speech
  call assert_equal("Whatever.", &
                    hey("It's OK if you don't want to go work for NASA."), &
                    "using acronyms in regular speech")

! Test 23: no letters
  call assert_equal("Whatever.", &
                    hey("1, 2, 3"), &
                    "no letters")

! Test 24: statement containing question mark
  call assert_equal("Whatever.", &
                    hey("Ending with ? means a question."), &
                    "statement containing question mark")

! Test 25: starting with whitespace
  call assert_equal("Whatever.", &
                    hey("         hmmmmmmm..."), &
                    "starting with whitespace")

! Test 26: non-question ending with whitespace
  call assert_equal("Whatever.", &
                    hey("This is a statement ending with whitespace      "), &
                    "non-question ending with whitespace")



  call test_report()

end program
