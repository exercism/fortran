test_suite hello_world

setup
end setup

test say_hi
  assert_equal( 'Hello World' , hello() )
end test

end test_suite
