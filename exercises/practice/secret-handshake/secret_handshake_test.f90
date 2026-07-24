! The tests were created from https://github.com/exercism/problem-specifications/blob/main/exercises/secret-handshake/canonical-data.json

program secret_handshake_test_main
  use TesterMain
  use secret_handshake

  implicit none

  ! Test 1: wink for 1
  
  call assert_equal([character(len=20) :: 'wink'], commands(1), &
                    "wink for 1")

  ! Test 2: double blink for 10
  
  call assert_equal([character(len=20) :: 'double blink'], commands(2), &
                    "double blink for 10")

  ! Test 3: close your eyes for 100
  
  call assert_equal([character(len=20) :: 'close your eyes'], commands(4), &
                    "close your eyes for 100")

  ! Test 4: jump for 1000
  
  call assert_equal([character(len=20) :: 'jump'], commands(8), &
                    "jump for 1000")

  ! Test 5: combine two actions
  
  call assert_equal([character(len=20) :: 'wink', 'double blink'], commands(3), &
                    "combine two actions")

  ! Test 6: reverse two actions
  
  call assert_equal([character(len=20) :: 'double blink', 'wink'], commands(19), &
                    "reverse two actions")

  ! Test 7: reversing one action gives the same action
  
  call assert_equal([character(len=20) :: 'jump'], commands(24), &
                    "reversing one action gives the same action")

  ! Test 8: reversing no actions still gives no actions
  
  call assert_equal([character(len=20) :: ], commands(16), &
                    "reversing no actions still gives no actions")

  ! Test 9: all possible actions
  
  call assert_equal([character(len=20) :: 'wink', 'double blink', 'close your eyes', 'jump'], commands(15), &
                    "all possible actions")

  ! Test 10: reverse all possible actions
  
  call assert_equal([character(len=20) :: 'jump', 'close your eyes', 'double blink', 'wink'], commands(31), &
                    "reverse all possible actions")

  ! Test 11: do nothing for zero
  
  call assert_equal([character(len=20) :: ], commands(0), &
                 "do nothing for zero")

  call test_report()

end program
