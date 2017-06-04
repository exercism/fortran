test_suite difference_of_squares

setup
end setup

test square_of_sum_1
  assert_equal( 1, square_of_sum(1) )
end test

Xtest square_of_sum_5
  assert_equal( 225, square_of_sum(5) )
end test

Xtest square_of_sum_100
  assert_equal( 25502500, square_of_sum(100) )
end test

Xtest sum_of_squares_1
  assert_equal( 1, sum_of_squares(1) )
end test

Xtest sum_of_squares_5
  assert_equal( 55, sum_of_squares(5) )
end test

Xtest sum_of_squares_100
  assert_equal( 338350, sum_of_squares(100) )
end test

Xtest difference_of_squares_1
  assert_equal( 0, difference(1) )
end test

Xtest difference_of_squares_5
  assert_equal( 170, difference(5) )
end test

Xtest difference_of_squares_100
 assert_equal( 25164150, difference(100) )
end test

end test_suite
