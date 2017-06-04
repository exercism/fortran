test_suite raindrops

setup
end setup

test the_sound_for_1_is_1
  assert_equal( '1', convert(1) )
end test

Xtest the_sound_for_3_is_pling
  assert_equal( 'Pling', convert(3) )
end test

Xtest the_sound_for_5_is_plang
  assert_equal( 'Plang', convert(5) )
end test

Xtest the_sound_for_7_is_plong
  assert_equal( 'Plong', convert(7) )
end test

Xtest the_sound_for_6_is_pling_as_it_has_a_factor_3
  assert_equal( 'Pling', convert(6) )
end test

Xtest two_to_the_power_3_does_not_make_a_raindrop_sound
  assert_equal( '8', convert(8) )
end test

Xtest the_sound_for_9_is_pling_as_it_has_factor_3
  assert_equal( 'Pling', convert(9) )
end test

Xtest the_sound_for_10_is_plang_as_it_has_a_factor_5
  assert_equal( 'Plang', convert(10) )
end test

Xtest the_sound_for_14_is_plong_as_it_has_a_factor_of_7
  assert_equal( 'Plong', convert(14) )
end test

Xtest the_sound_for_15_is_plingplang_as_it_has_factors_3_and_5
  assert_equal( 'PlingPlang', convert(15) )
end test

Xtest the_sound_for_21_is_plingplong_as_it_has_factors_3_and_7
  assert_equal( 'PlingPlong', convert(21) )
end test

Xtest the_sound_for_25_is_plang_as_it_has_a_factor_of_5
  assert_equal( 'Plang', convert(25) )
end test

Xtest the_sound_for_27_is_pling_as_it_has_a_factor_of_3
  assert_equal( 'Pling', convert(27) )
end test

Xtest the_sound_for_35_is_plangplong_as_it_has_factors_5_and_7
  assert_equal( 'PlangPlong', convert(35) )
end test

Xtest the_sound_for_49_is_plong_as_it_has_a_factor_of_7
  assert_equal( 'Plong', convert(49) )
end test

Xtest the_sound_for_105_is_plingplangplong
  assert_equal( 'PlingPlangPlong', convert(105) )
end test

Xtest the_sound_for_3125_is_plang_as_it_has_a_factor_5
  assert_equal( 'Plang', convert(3125) )
end test

Xtest the_sound_for_3131_is_3131
  assert_equal( '3131', convert(3131) )
end test

end test_suite
