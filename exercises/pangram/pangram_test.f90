
    
program pangram_test_main
  use TesterMain
  use pangram
  implicit none

    
  ! Test 1: sentence empty
  call assert_equal(.false., is_pangram(""), "sentence empty")
  ! Test 2: recognizes a perfect lower case pangram
  call assert_equal(.true., is_pangram("abcdefghijklmnopqrstuvwxyz"), "recognizes a perfect lower case pangram")
  ! Test 3: pangram with only lower case
  call assert_equal(.true., is_pangram("the quick brown fox jumps over the lazy dog"), "pangram with only lower case")
  ! Test 4: missing character 'x'
  call assert_equal(.false., is_pangram("a quick movement of the enemy will jeopardize five gunboats"), "missing character 'x'")
  ! Test 5: another missing character, e.g. 'h'
  call assert_equal(.false., is_pangram("five boxing wizards jump quickly at it"), "another missing character, e.g. 'h'")
  ! Test 6: pangram with underscores
  call assert_equal(.true., is_pangram("the_quick_brown_fox_jumps_over_the_lazy_dog"), "pangram with underscores")
  ! Test 7: pangram with numbers
  call assert_equal(.true., is_pangram("the 1 quick brown fox jumps over the 2 lazy dogs"), "pangram with numbers")
  ! Test 8: missing letters replaced by numbers
  call assert_equal(.false., is_pangram("7h3 qu1ck brown fox jumps ov3r 7h3 lazy dog"), "missing letters replaced by numbers")
  ! Test 9: pangram with mixed case and punctuation
  call assert_equal(.true., is_pangram("Five quacking Zephyrs jolt my wax bed."), "pangram with mixed case and punctuation")
  ! Test 10: upper and lower case versions of the same character should not be counted separately
  call assert_equal(.false., is_pangram("the quick brown fox jumps over with lazy FX"), &
    &  "upper and lower case versions of the same character should not be counted separately")
 
  call test_end()
 
end program
 
