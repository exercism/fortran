! The tests were created from https://github.com/exercism/problem-specifications/blob/main/exercises/isogram/canonical-data.json

program isogram_test_main
  use TesterMain
  use isogram
  implicit none

  ! Test 1: empty string
  call assert_equal(.true., isIsogram(""), &
    "empty string")

  ! Test 2: isogram with only lower case characters
  call assert_equal(.true., isIsogram("isogram"), &
    "isogram with only lower case characters")

  ! Test 3: word with one duplicated character
  call assert_equal(.false., isIsogram("eleven"), &
    "word with one duplicated character")

  ! Test 4: word with one duplicated character from the end of the alphabet
  call assert_equal(.false., isIsogram("zzyzx"), &
    "word with one duplicated character from the end of the alphabet")

  ! Test 5: longest reported english isogram
  call assert_equal(.true., isIsogram("subdermatoglyphic"), &
    "longest reported english isogram")

  ! Test 6: word with duplicated character in mixed case
  call assert_equal(.false., isIsogram("Alphabet"), &
    "word with duplicated character in mixed case")

  ! Test 7: word with duplicated character in mixed case, lowercase first
  call assert_equal(.false., isIsogram("alphAbet"), &
    "word with duplicated character in mixed case, lowercase first")

  ! Test 8: hypothetical isogrammic word with hyphen
  call assert_equal(.true., isIsogram("thumbscrew-japingly"), &
    "hypothetical isogrammic word with hyphen")

  ! Test 9: hypothetical word with duplicated character following hyphen
  call assert_equal(.false., isIsogram("thumbscrew-jappingly"), &
    "hypothetical word with duplicated character following hyphen")

  ! Test 10: isogram with duplicated hyphen
  call assert_equal(.true., isIsogram("six-year-old"), &
    "isogram with duplicated hyphen")

  ! Test 11: made-up name that is an isogram
  call assert_equal(.true., isIsogram("Emily Jung Schwartzkopf"), &
    "made-up name that is an isogram")

  ! Test 12: duplicated character in the middle
  call assert_equal(.false., isIsogram("accentor"), &
    "duplicated character in the middle")

  ! Test 13: same first and last characters
  call assert_equal(.false., isIsogram("angola"), &
    "same first and last characters")

  ! Test 14: word with duplicated character and with two hyphens
  call assert_equal(.false., isIsogram("up-to-date"), &
    "word with duplicated character and with two hyphens")

  call test_report()

end program
