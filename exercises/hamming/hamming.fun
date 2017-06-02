test_suite hamming
  integer :: distance

setup
end setup

test identical_strands
  assert_true( compute('A', 'A', distance ) )
  assert_equal( 0, distance )
end test

test long_identical_strands
  assert_true( compute('GGACTGA', 'GGACTGA', distance ) )
  assert_equal( 0, distance )
end test

test complete_distance_in_single_nucleotide_strands
  assert_true( compute('A', 'G', distance) )
  assert_equal( 1, distance )
end test

test complete_distance_in_small_strands
  assert_true( compute('AG', 'CT', distance) )
  assert_equal( 2, distance )
end test

test small_distance_in_small_strands
  assert_true( compute('AT', 'CT', distance) )
  assert_equal( 1, distance )
end test

test small_distance
  assert_true( compute('GGACG', 'GGTCG', distance) )
  assert_equal( 1, distance )
end test

test small_distance_in_long_strands
  assert_true( compute('ACCAGGG', 'ACTATGG', distance) )
  assert_equal( 2, distance )
end test

test non_unique_character_in_first_strand
  assert_true( compute('AGA', 'AGG', distance) )
  assert_equal( 1, distance )
end test

test same_nucleotides_in_different_positions
  assert_true( compute('TAG', 'GAT', distance) )
  assert_equal( 2, distance )
end test

test large_distance
  assert_true( compute('GATACA', 'GCATAA', distance) )
  assert_equal( 4, distance )
end test

test large_distance_in_off_by_one_strand
  assert_true( compute('GGACGGATTCTG', 'AGGACGGATTCT', distance) )
  assert_equal( 9, distance )
end test

test empty_strands
  assert_true( compute('', '', distance) )
  assert_equal( 0, distance )
end test

test disallow_first_strand_longer
  assert_false( compute('AATG', 'AAA', distance) )
end test

test disallow_second_strand_longer
  assert_false( compute('ATA', 'AGTG', distance) )
end test

end test_suite
