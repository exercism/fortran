test_suite pangram

setup
end setup

test sentance_empty
  assert_false( is_pangram('') )
end test

Xtest pangram_with_only_lower_case
  assert_true( is_pangram('the quick brown fox jumps over the lazy dog') )
end test

Xtest missing_character_x
  assert_false( is_pangram('a quick movement of the enemy will jeopordize five gunboats') )
end test

Xtest missing_another_character_x
  assert_false( is_pangram('the quick brown fish jumps over the lazy dog') )
end test

Xtest panagram_with_underscores
  assert_true( is_pangram('the_quick_brown_fox_jumps_over_the_lazy_dog') )
end test

Xtest panagram_with_numbers
  assert_true( is_pangram('the 1 quick brown fox jumps over the 2 lazy dogs') )
end test

Xtest pangram_missing_letters_replaced_by_numbers
  assert_false( is_pangram('7h3 qu1ck brown fox jumps ov3r 7h3 lazy dog') )
end test

Xtest pangram_with_mixed_case_and_punctuation
  assert_true( is_pangram('""Five quacking Zephyrs jolt my wax bed.""') )
end test

Xtest upper_and_lower_case_versions_of_the_same_character
  assert_false( is_pangram('the quick brown fox jumped over the lazy FOX') )
end test

end test_suite
