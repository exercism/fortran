! The tests were created from https://github.com/exercism/problem-specifications/blob/main/exercises/roman-numerals/canonical-data.json

program roman_numerals_test_main
  use TesterMain
  use roman_numerals
  implicit none

  ! Test 1: 1 is I
  call assert_equal("I", roman(1), "1 is I")

  ! Test 2: 2 is II
  call assert_equal("II", roman(2), "2 is II")

  ! Test 3: 3 is III
  call assert_equal("III", roman(3), "3 is III")

  ! Test 4: 4 is IV
  call assert_equal("IV", roman(4), "4 is IV")

  ! Test 5: 5 is V
  call assert_equal("V", roman(5), "5 is V")

  ! Test 6: 6 is VI
  call assert_equal("VI", roman(6), "6 is VI")

  ! Test 7: 9 is IX
  call assert_equal("IX", roman(9), "9 is IX")

  ! Test 8: 16 is XVI
  call assert_equal("XVI", roman(16), "16 is XVI")

  ! Test 9: 27 is XXVII
  call assert_equal("XXVII", roman(27), "27 is XXVII")

  ! Test 10: 48 is XLVIII
  call assert_equal("XLVIII", roman(48), "48 is XLVIII")

  ! Test 11: 49 is XLIX
  call assert_equal("XLIX", roman(49), "49 is XLIX")

  ! Test 12: 59 is LIX
  call assert_equal("LIX", roman(59), "59 is LIX")

  ! Test 13: 66 is LXVI
  call assert_equal("LXVI", roman(66), "66 is LXVI")

  ! Test 14: 93 is XCIII
  call assert_equal("XCIII", roman(93), "93 is XCIII")

  ! Test 15: 141 is CXLI
  call assert_equal("CXLI", roman(141), "141 is CXLI")

  ! Test 16: 163 is CLXIII
  call assert_equal("CLXIII", roman(163), "163 is CLXIII")

  ! Test 17: 166 is CLXVI
  call assert_equal("CLXVI", roman(166), "166 is CLXVI")

  ! Test 18: 402 is CDII
  call assert_equal("CDII", roman(402), "402 is CDII")

  ! Test 19: 575 is DLXXV
  call assert_equal("DLXXV", roman(575), "575 is DLXXV")

  ! Test 20: 666 is DCLXVI
  call assert_equal("DCLXVI", roman(666), "666 is DCLXVI")

  ! Test 21: 911 is CMXI
  call assert_equal("CMXI", roman(911), "911 is CMXI")

  ! Test 22: 1024 is MXXIV
  call assert_equal("MXXIV", roman(1024), "1024 is MXXIV")

  ! Test 23: 1666 is MDCLXVI
  call assert_equal("MDCLXVI", roman(1666), "1666 is MDCLXVI")

  ! Test 24: 3000 is MMM
  call assert_equal("MMM", roman(3000), "3000 is MMM")

  ! Test 25: 3001 is MMMI
  call assert_equal("MMMI", roman(3001), "3001 is MMMI")

  ! Test 26: 3999 is MMMCMXCIX
  call assert_equal("MMMCMXCIX", roman(3999), "3999 is MMMCMXCIX")

  call test_report()

end program

