
! This test was created from ../../exercism/problem-specifications/exercises/hamming/canonical-data.json
! version: 2.3.0
!

program hamming_test_main
  use TesterMain
  use hamming
  implicit none
  integer distance

  ! Test 1: empty strands
  call assert_equal(.true., compute("", "", distance), "empty strands")
  call assert_equal(0, distance)
  ! Test 2: single letter identical strands
  call assert_equal(.true., compute("A", "A", distance), "single letter identical strands")
  call assert_equal(0, distance)
  ! Test 3: single letter different strands
  call assert_equal(.true., compute("G", "T", distance), "single letter different strands")
  call assert_equal(1, distance)
  ! Test 4: long identical strands
  call assert_equal(.true., compute("GGACTGAAATCTG", "GGACTGAAATCTG", distance), "long identical strands")
  call assert_equal(0, distance)
  ! Test 5: long different strands
  call assert_equal(.true., compute("GGACGGATTCTG", "AGGACGGATTCT", distance), "long different strands")
  call assert_equal(9, distance)
  ! Test 6: disallow first strand longer
  call assert_equal(.false., compute("AATG", "AAA", distance), "disallow first strand longer")
  call assert_equal(0, distance)
  ! Test 7: disallow second strand longer
  call assert_equal(.false., compute("ATA", "AGTG", distance), "disallow second strand longer")
  call assert_equal(0, distance)
  ! Test 8: disallow left empty strand
  call assert_equal(.false., compute("", "G", distance), "disallow left empty strand")
  call assert_equal(0, distance)
  ! Test 9: disallow right empty strand
  call assert_equal(.false., compute("G", "", distance), "disallow right empty strand")
  call assert_equal(0, distance)

  call test_report()

end program

