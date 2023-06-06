program hello_world_test_main
   use TesterMain
   use hello_world

   implicit none

   ! The hello_world.f90 must contain a module called "hello_world" and implement
   ! the function "hello" which must return "Hello, World!".

   ! Test 1: Say Hi!
   ! Explaination: This test expects "Hello, World!" to be returned from the function "hello()"
   ! and the test description is "Say Hi!"
   call assert_equal("Hello, World!", hello(), "Say Hi!")

   ! This last call is to create a test report.
   call test_report()
end program

