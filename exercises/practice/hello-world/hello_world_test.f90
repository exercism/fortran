! These tests are auto-generated with test data from:
! https://github.com/exercism/problem-specifications/blob/main/exercises/hello-world/canonical-data.json
! File last updated on 2026-10-17T01:05:22+00:00

program hello_world_test_main
   use TesterMain
   use hello_world

   implicit none

   ! Test 1: Say Hi!
   call assert_equal("Hello, World!", hello(), "Say Hi!")

   call test_report()

end program
