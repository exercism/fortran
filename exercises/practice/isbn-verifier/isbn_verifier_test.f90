! The tests were created from https://github.com/exercism/problem-specifications/blob/main/exercises/isbn-verifier/canonical-data.json

program isbn_verifier_test_main
  use TesterMain
  use isbn_verifier
  implicit none

! Test 1: valid isbn
  call assert_equal(.true., isValid("3-598-21508-8"), "valid isbn")

! Test 2: invalid isbn check digit
  call assert_equal(.false., isValid("3-598-21508-9"), "invalid isbn check digit")

! Test 3: valid isbn with a check digit of 10
  call assert_equal(.true., isValid("3-598-21507-X"), "valid isbn with a check digit of 10")

! Test 4: check digit is a character other than X
  call assert_equal(.false., isValid("3-598-21507-A"), "check digit is a character other than X")

! Test 5: invalid check digit in isbn is not treated as zero
  call assert_equal(.false., isValid("4-598-21507-B"), "invalid check digit in isbn is not treated as zero")

! Test 6: invalid character in isbn is not treated as zero
  call assert_equal(.false., isValid("3-598-P1581-X"), "invalid character in isbn is not treated as zero")

! Test 7: X is only valid as a check digit
  call assert_equal(.false., isValid("3-598-2X507-9"), "X is only valid as a check digit")

! Test 8: only one check digit is allowed
  call assert_equal(.false., isValid("3-598-21508-96"), "only one check digit is allowed")

! Test 9: X is not substituted by the value 10
  call assert_equal(.false., isValid("3-598-2X507-5"), "X is not substituted by the value 10")

! Test 10: valid isbn without separating dashes
  call assert_equal(.true., isValid("3598215088"), "valid isbn without separating dashes")

! Test 11: isbn without separating dashes and X as check digit
  call assert_equal(.true., isValid("359821507X"), "isbn without separating dashes and X as check digit")

! Test 12: isbn without check digit and dashes
  call assert_equal(.false., isValid("359821507"), "isbn without check digit and dashes")

! Test 13: too long isbn and no dashes
  call assert_equal(.false., isValid("3598215078X"), "too long isbn and no dashes")

! Test 14: too short isbn
  call assert_equal(.false., isValid("00"), "too short isbn")

! Test 15: isbn without check digit
  call assert_equal(.false., isValid("3-598-21507"), "isbn without check digit")

! Test 16: check digit of X should not be used for 0
  call assert_equal(.false., isValid("3-598-21515-X"), "check digit of X should not be used for 0")

! Test 17: empty isbn
  call assert_equal(.false., isValid(""), "empty isbn")

! Test 18: input is 9 characters
  call assert_equal(.false., isValid("134456729"), "input is 9 characters")

! Test 19: invalid characters are not ignored after checking length
  call assert_equal(.false., isValid("3132P34035"), "invalid characters are not ignored after checking length")

! Test 20: invalid characters are not ignored before checking length
  call assert_equal(.false., isValid("3598P215088"), "invalid characters are not ignored before checking length")

! Test 21: input is too long but contains a valid isbn
  call assert_equal(.false., isValid("98245726788"), "input is too long but contains a valid isbn")

call test_report()

end program
