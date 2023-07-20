! The tests were created from https://github.com/exercism/problem-specifications/blob/main/exercises/luhn/canonical-data.json

program luhn_test_main
  use TesterMain
  use luhn
  implicit none

  ! Test 1: single digit strings can not be valid
  call assert_equal(.false., validate("1"), &
    "single digit strings can not be valid")

  ! Test 2: a single zero is invalid
  call assert_equal(.false., validate("0"), &
    "a single zero is invalid")

  ! Test 3: a simple valid SIN that remains valid if reversed
  call assert_equal(.true., validate("059"), &
    "a simple valid SIN that remains valid if reversed")

  ! Test 4: a simple valid SIN that becomes invalid if reversed
  call assert_equal(.true., validate("59"), &
    "a simple valid SIN that becomes invalid if reversed")

  ! Test 5: a valid Canadian SIN
  call assert_equal(.true., validate("055 444 285"), &
    "a valid Canadian SIN")

  ! Test 6: invalid Canadian SIN
  call assert_equal(.false., validate("055 444 286"), &
    "invalid Canadian SIN")

  ! Test 7: invalid credit card
  call assert_equal(.false., validate("8273 1232 7352 0569"), &
    "invalid credit card")

  ! Test 8: invalid long number with an even remainder
  call assert_equal(.false., validate("1 2345 6789 1234 5678 9012"), &
    "invalid long number with an even remainder")

  ! Test 9: invalid long number with a remainder divisible by 5
  call assert_equal(.false., validate("1 2345 6789 1234 5678 9013"), &
    "invalid long number with a remainder divisible by 5")

  ! Test 10: valid number with an even number of digits
  call assert_equal(.true., validate("095 245 88"), &
    "valid number with an even number of digits")

  ! Test 11: valid number with an odd number of spaces
  call assert_equal(.true., validate("234 567 891 234"), &
    "valid number with an odd number of spaces")

  ! Test 12: valid strings with a non-digit added at the end become invalid
  call assert_equal(.false., validate("059a"), &
    "valid strings with a non-digit added at the end become invalid")

  ! Test 13: valid strings with punctuation included become invalid
  call assert_equal(.false., validate("055-444-285"), &
    "valid strings with punctuation included become invalid")

  ! Test 14: valid strings with symbols included become invalid
  call assert_equal(.false., validate("055# 444$ 285"), &
    "valid strings with symbols included become invalid")

  ! Test 15: single zero with space is invalid
  call assert_equal(.false., validate(" 0"), &
    "single zero with space is invalid")

  ! Test 16: more than a single zero is valid
  call assert_equal(.true., validate("0000 0"), &
    "more than a single zero is valid")

  ! Test 17: input digit 9 is correctly converted to output digit 9
  call assert_equal(.true., validate("091"), &
    "input digit 9 is correctly converted to output digit 9")

  ! Test 18: very long input is valid
  call assert_equal(.true., validate("9999999999 9999999999 9999999999 9999999999"), &
    "very long input is valid")

  ! Test 19: valid luhn with an odd number of digits and non zero first digit
  call assert_equal(.true., validate("109"), &
    "valid luhn with an odd number of digits and non zero first digit")

  ! Test 20: using ascii value for non-doubled non-digit isn't allowed
  call assert_equal(.false., validate("055b 444 285"), &
    "using ascii value for non-doubled non-digit isn't allowed")

  ! Test 21: using ascii value for doubled non-digit isn't allowed
  call assert_equal(.false., validate(":9"), &
    "using ascii value for doubled non-digit isn't allowed")

  ! Test 22: non-numeric, non-space char in the middle with a sum that's divisible by 10 isn't allowed
  call assert_equal(.false., validate("59%59"), &
    "non-numeric, non-space char in the middle with a sum that's divisible by 10 isn't allowed")

  call test_report()

end program
