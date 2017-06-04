test_suite rna_transcription

setup
end setup

test rna_complement_of_cytosine_is_guanine
  assert_equal( 'G', complement('C') )
end test

Xtest rna_complement_of_guanine_is_cytosine
  assert_equal( 'C', complement('G') )
end test

Xtest rna_complement_of_thymine_is_adenine
  assert_equal( 'A', complement('T') )
end test

Xtest rna_complement_of_adenine_is_uracil
  assert_equal( 'U', complement('A') )
end test

Xtest rna_complement
  assert_equal( 'UGCACCAGAAUU', complement('ACGTGGTCTTAA') )
end test

Xtest dna_correctly_handles_invalid_input
  assert_equal( '', complement('U') )
end test

Xtest dna_correctly_handles_completely_invalid_input
  assert_equal( '', complement('XXX') )
end test

Xtest dna_correctly_handles_partially_invalid_input
  assert_equal( '', complement('ACGTXXXCTTAA') )
end test

end test_suite
