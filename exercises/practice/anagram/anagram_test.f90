! These tests are auto-generated with test data from:
! https://github.com/exercism/problem-specifications/blob/main/exercises/anagram/canonical-data.json
! File last updated on 2026-10-18T23:31:42+00:00

program anagram_test_main
  use TesterMain
  use anagram

  implicit none

  ! Test 1: no matches
  call assert_equal([character(len=20) :: ], &
    findAnagrams("diaper", [character(len=20) :: "hello", "world", "zombies", "pants"]), &
    "no matches")

  ! Test 2: detects two anagrams
  call assert_equal([character(len=20) :: "lemons", "melons"], &
    findAnagrams("solemn", [character(len=20) :: "lemons", "cherry", "melons"]), &
    "detects two anagrams")

  ! Test 3: does not detect anagram subsets
  call assert_equal([character(len=20) :: ], &
    findAnagrams("good", [character(len=20) :: "dog", "goody"]), &
    "does not detect anagram subsets")

  ! Test 4: detects anagram
  call assert_equal([character(len=20) :: "inlets"], &
    findAnagrams("listen", [character(len=20) :: "enlists", "google", "inlets", "banana"]), &
    "detects anagram")

  ! Test 5: detects three anagrams
  call assert_equal([character(len=20) :: "gallery", "regally", "largely"], &
    findAnagrams("allergy", [character(len=20) :: "gallery", "ballerina", "regally", "clergy", "largely", "leading"]), &
    "detects three anagrams")

  ! Test 6: detects multiple anagrams with different case
  call assert_equal([character(len=20) :: "Eons", "ONES"], &
    findAnagrams("nose", [character(len=20) :: "Eons", "ONES"]), &
    "detects multiple anagrams with different case")

  ! Test 7: does not detect non-anagrams with identical checksum
  call assert_equal([character(len=20) :: ], &
    findAnagrams("mass", [character(len=20) :: "last"]), &
    "does not detect non-anagrams with identical checksum")

  ! Test 8: detects anagrams case-insensitively
  call assert_equal([character(len=20) :: "Carthorse"], &
    findAnagrams("Orchestra", [character(len=20) :: "cashregister", "Carthorse", "radishes"]), &
    "detects anagrams case-insensitively")

  ! Test 9: detects anagrams using case-insensitive subject
  call assert_equal([character(len=20) :: "carthorse"], &
    findAnagrams("Orchestra", [character(len=20) :: "cashregister", "carthorse", "radishes"]), &
    "detects anagrams using case-insensitive subject")

  ! Test 10: detects anagrams using case-insensitive possible matches
  call assert_equal([character(len=20) :: "Carthorse"], &
    findAnagrams("orchestra", [character(len=20) :: "cashregister", "Carthorse", "radishes"]), &
    "detects anagrams using case-insensitive possible matches")

  ! Test 11: does not detect an anagram if the original word is repeated
  call assert_equal([character(len=20) :: ], &
    findAnagrams("go", [character(len=20) :: "goGoGO"]), &
    "does not detect an anagram if the original word is repeated")

  ! Test 12: anagrams must use all letters exactly once
  call assert_equal([character(len=20) :: ], &
    findAnagrams("tapper", [character(len=20) :: "patter"]), &
    "anagrams must use all letters exactly once")

  ! Test 13: words are not anagrams of themselves
  call assert_equal([character(len=20) :: ], &
    findAnagrams("BANANA", [character(len=20) :: "BANANA"]), &
    "words are not anagrams of themselves")

  ! Test 14: words are not anagrams of themselves even if letter case is partially different
  call assert_equal([character(len=20) :: ], &
    findAnagrams("BANANA", [character(len=20) :: "Banana"]), &
    "words are not anagrams of themselves even if letter case is partially different")

  ! Test 15: words are not anagrams of themselves even if letter case is completely different
  call assert_equal([character(len=20) :: ], &
    findAnagrams("BANANA", [character(len=20) :: "banana"]), &
    "words are not anagrams of themselves even if letter case is completely different")

  ! Test 16: words other than themselves can be anagrams
  call assert_equal([character(len=20) :: "Silent"], &
    findAnagrams("LISTEN", [character(len=20) :: "LISTEN", "Silent"]), &
    "words other than themselves can be anagrams")

  ! Test 17: handles case of greek letters
  call assert_equal([character(len=20) :: "ΒΓΑ", "γβα"], &
    findAnagrams("ΑΒΓ", [character(len=20) :: "ΒΓΑ", "ΒΓΔ", "γβα", "αβγ"]), &
    "handles case of greek letters")

  ! Test 18: different characters may have the same bytes
  call assert_equal([character(len=20) :: ], &
    findAnagrams("a⬂", [character(len=20) :: "€a"]), &
    "different characters may have the same bytes")

  call test_report()

end program
