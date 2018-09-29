
    
program rna_transcription_test_main
  use TesterMain
  use rna_transcription
  implicit none

    
  ! Test 1: Empty RNA sequence
  call assert_equal("", complement(""), "Empty RNA sequence")
  ! Test 2: RNA complement of cytosine is guanine
  call assert_equal("G", complement("C"), "RNA complement of cytosine is guanine")
  ! Test 3: RNA complement of guanine is cytosine
  call assert_equal("C", complement("G"), "RNA complement of guanine is cytosine")
  ! Test 4: RNA complement of thymine is adenine
  call assert_equal("A", complement("T"), "RNA complement of thymine is adenine")
  ! Test 5: RNA complement of adenine is uracil
  call assert_equal("U", complement("A"), "RNA complement of adenine is uracil")
  ! Test 6: RNA complement
  call assert_equal("UGCACCAGAAUU", complement("ACGTGGTCTTAA"), "RNA complement")
 
  call test_end()
 
end program
 
