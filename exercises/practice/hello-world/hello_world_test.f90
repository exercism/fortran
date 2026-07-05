! The tests were created from https://github.com/exercism/problem-specifications/blob/main/exercises/hello-world/canonical-data.json

program hello_world_test_main
   use TesterMain
   use hello_world

   implicit none

   ! Test 1: Say Hi!
   call assert_equal("Hello, World!", hello(), "Say Hi!")

   call test_report()

end program
