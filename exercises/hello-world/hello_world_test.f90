! This test was created from ..\..\exercism\problem-specifications\exercises\hello-world\canonical-data.json
! version: 1.1.0 
!
program hello_world_test_main
  use TesterMain
  use hello_world 

  implicit none

  !! About the test comments:

  ! Test 1: Say Hi!
  call assert_equal("Hello, World!", hello(), "Say Hi!")
  call test_report()
end program

