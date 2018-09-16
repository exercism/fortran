
    
program hamming_test_main
  use TesterMain
  use hamming
  implicit none

    
  ! Test 1: empty strands
  call assert_equal(0, distance( "", ""), "empty strands")
  ! Test 2: identical strands
  call assert_equal(0, distance( "A", "A"), "identical strands")
  ! Test 3: long identical strands
  call assert_equal(0, distance( "GGACTGA", "GGACTGA"), "long identical strands")
  ! Test 4: complete distance in single nucleotide strands
  call assert_equal(1, distance( "A", "G"), "complete distance in single nucleotide strands")
  ! Test 5: complete distance in small strands
  call assert_equal(2, distance( "AG", "CT"), "complete distance in small strands")
  ! Test 6: small distance in small strands
  call assert_equal(1, distance( "AT", "CT"), "small distance in small strands")
  ! Test 7: small distance
  call assert_equal(1, distance( "GGACG", "GGTCG"), "small distance")
  ! Test 8: small distance in long strands
  call assert_equal(2, distance( "ACCAGGG", "ACTATGG"), "small distance in long strands")
  ! Test 9: non-unique character in first strand
  call assert_equal(1, distance( "AAG", "AAA"), "non-unique character in first strand")
  ! Test 10: non-unique character in second strand
  call assert_equal(1, distance( "AAA", "AAG"), "non-unique character in second strand")
  ! Test 11: same nucleotides in different positions
  call assert_equal(2, distance( "TAG", "GAT"), "same nucleotides in different positions")
  ! Test 12: large distance
  call assert_equal(4, distance( "GATACA", "GCATAA"), "large distance")
  ! Test 13: large distance in off-by-one strand
  call assert_equal(9, distance( "GGACGGATTCTG", "AGGACGGATTCT"), "large distance in off-by-one strand")
  ! Test 14: disallow first strand longer
  call assert_equal(-1, distance( "AATG", "AAA"), "disallow first strand longer")
  ! Test 15: disallow second strand longer
  call assert_equal(-1, distance( "ATA", "AGTG"), "disallow second strand longer")
 
  call test_end()
 
end program
 
