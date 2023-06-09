! The tests were created from https://github.com/exercism/problem-specifications/blob/main/exercises/reverse-string/canonical-data.json

program reverse_string_test_main
  use TesterMain
  use reverse_string
  implicit none

  ! Test 1: an empty string
  call assert_equal("", reverse(""), "an empty string")

  ! Test 2: a word
  call assert_equal("tobor", reverse("robot"), "a word")

  ! Test 3: a capitalized word
  call assert_equal("nemaR", reverse("Ramen"), "a capitalized word")

  ! Test 4: a sentence with punctuation
  call assert_equal("!yrgnuh m'I", reverse("I'm hungry!"), "a sentence with punctuation")

  ! Test 5: a palindrome
  call assert_equal("racecar", reverse("racecar"), "a palindrome")

  ! Test 6: an even-sized word
  call assert_equal("reward", reverse("drawer"), "an even-sized word")

  call test_report()

end program

