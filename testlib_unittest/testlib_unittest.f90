
program testlib_unittest
  use TesterMain
  implicit none

  ! check all asserts and compare results.json output
  ! This test is "WILL_FAIL true" ie return code=1

  call assert_equal(1, 1, 'OK int')
  call assert_equal(1, 2, 'FAIL int')
  call assert_equal([1,2,3], [1,2,3], 'OK int array')
  call assert_equal([1,2,3], [1,2,-3], 'FAIL int array')
  call assert_equal(1.d0, 1.d0, 'OK double')
  call assert_equal(1.d0, 2.d0, 'FAIL double')
  call assert_equal(1.0, 1.0, 'OK real')
  call assert_equal(1.0, 2.0, 'FAIL real')
  call assert_equal(.true., .true., 'OK logical')
  call assert_equal(.true., .false., 'FAIL logical')
  call assert_equal('my string', 'my string', 'OK string')
  call assert_equal('my string', 'not my string', 'FAIL string')
  
  if (TESTS_RUN/=12) then
    write(*,*) 'Expected TESTS_RUN==12, but got TESTS_RUN=', TESTS_RUN
    stop 0 ! This should cause FAIL, due to WILL_FAIL true
  endif

  call test_report()

end program
