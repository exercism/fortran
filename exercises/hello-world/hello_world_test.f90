
program hello_world_test
  use TesterMain
  use hello_world
  implicit none

  ! Test 1: test hello world
  call assert_equal("Hello, World!", hello(), "test hello world")
  
  call test_end()

end program 

