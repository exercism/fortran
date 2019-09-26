!------------------------------------------------------------------
!------------------------------------------------------------------
! MIT License
!
! Copyright (c) 2019 Exercism
!
! Permission is hereby granted, free of charge, to any person obtaining a copy
! of this software and associated documentation files (the "Software"), to deal
! in the Software without restriction, including without limitation the rights
! to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
! copies of the Software, and to permit persons to whom the Software is
! furnished to do so, subject to the following conditions:

! The above copyright notice and this permission notice shall be included in all
! copies or substantial portions of the Software.

! THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
! IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
! FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
! AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
! LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
! OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
! SOFTWARE.
!------------------------------------------------------------------
!------------------------------------------------------------------
!
! USAGE:
!
! This is a custom-module built for testing of exercism.io Fortran track exercises.
!
! It should be used in test-code with
!
!   call assert_equal(input, expected, message)
!
! where input/expected may be one of: string(len=80), logical, integer or double precision.
!
! When used like below number of failed test is counted and summarized in 'test_report' routine.
!
!------------------------------------------------------------------
!   EXAMPLE from exercise bob
!------------------------------------------------------------------
!program bob_test_main
!  use TesterMain
!  use bob
!  implicit none
!
!  ! Test 1: stating something
!  call assert_equal("Whatever.", heyBob("Tom-ay-to, tom-aaaah-to."), "stating something")
!
!... more tests ...
!
!  call test_report()
!
!end program
!
!
!

!------------------------------------------------------------------
module TesterMain
!------------------------------------------------------------------
  implicit none

  integer :: TESTS_RUN = 0
  integer :: TESTS_FAILED = 0
  integer, parameter :: MAX_STRING_LEN = 80
  character(len=MAX_STRING_LEN) :: input_str
  character(len=MAX_STRING_LEN) :: expected_str
  integer :: input_int
  integer :: expected_int
  logical :: input_bool
  logical :: expected_bool
  double precision :: input_dble
  double precision :: expected_dble
  double precision, parameter :: TOL = 1.0D-8

  interface assert_equal
    module procedure assert_equal_str
    module procedure assert_equal_int
    module procedure assert_equal_dble
    module procedure assert_equal_bool
  end interface


contains

!------------------------------------------------------------------
  subroutine test_report()
    call logger('Test summary: '//trim(adjustl(i_to_s(TESTS_FAILED)))//' of '//trim(adjustl(i_to_s(TESTS_RUN)))//' tests failed')
    if (TESTS_FAILED==0) then
      STOP 0
    else
      STOP 1
    endif
  end subroutine

!------------------------------------------------------------------
  subroutine assert_equal_bool(e_bool,i_bool,msg)
    logical, intent(in) :: e_bool, i_bool
    character(len=*), intent(in), optional :: msg
    logical :: assert_test
    TESTS_RUN=TESTS_RUN+1
    assert_test = i_bool .eqv. e_bool
    if (.not. assert_test) then
      call test_fail_msg(msg)
      call elogger('Expected "'//trim(b_to_s(e_bool))//'" but got "'//trim(b_to_s(i_bool))//'"')
    endif
  end subroutine

!------------------------------------------------------------------
  subroutine assert_equal_str(estr,istr,msg)
    character(len=*), intent(in) :: estr,istr
    character(len=*), intent(in), optional :: msg
    logical :: assert_test
    TESTS_RUN=TESTS_RUN+1
    assert_test = istr == estr
    if (.not. assert_test) then
      call test_fail_msg(msg)
      call elogger('Expected "'//trim(estr)//'" but got "'//trim(istr)//'"')
    endif
  end subroutine

!------------------------------------------------------------------
  subroutine assert_equal_int(e_int,i_int,msg)
    integer, intent(in) :: e_int,i_int
    character(len=*), intent(in), optional :: msg
    logical :: assert_test
    TESTS_RUN=TESTS_RUN+1
    assert_test = i_int == e_int
    if (.not. assert_test) then
      call test_fail_msg(msg)
      call elogger('Expected "'//trim(adjustl(i_to_s(e_int)))//'" but got "' &
      & //trim(adjustl(i_to_s(i_int)))//'"' )
    endif
  end subroutine

!------------------------------------------------------------------
  subroutine assert_equal_dble(e_dble,i_dble,msg)
    double precision, intent(in) :: e_dble,i_dble
    character(len=*), intent(in), optional :: msg
    logical :: assert_test
    TESTS_RUN=TESTS_RUN+1
    assert_test = dabs(i_dble - e_dble) < TOL
    if (.not. assert_test) then
      call test_fail_msg(msg)
      call elogger('Expected "'//trim(adjustl(d_to_s(e_dble)))//'" but got "'&
      & //trim(adjustl(d_to_s(i_dble)))//'"')
    endif
  end subroutine

!------------------------------------------------------------------
! utilities
!------------------------------------------------------------------
! Interger to string
  function i_to_s(i)
    integer, intent(in) :: i
    character(len=MAX_STRING_LEN) :: i_to_s
    write(i_to_s, *) i
  end function

! Double precision to string
  function d_to_s(d)
    double precision, intent(in) :: d
    character(len=MAX_STRING_LEN) :: d_to_s
    write(d_to_s, *) d
  end function

! Logical/boolean to string
  function b_to_s(b)
    logical, intent(in) :: b
    character(len=5) :: b_to_s
    if (b) then
      b_to_s='True '
    else
      b_to_s='False'
    endif
  end function

!------------------------------------------------------------------
! Logger
!------------------------------------------------------------------
! logger routine, in case other than stdout is needed
  subroutine logger(msg)
    character(len=*) :: msg
    write(*,*) msg
  end subroutine

! Error logger
  subroutine elogger(msg)
    character(len=*) :: msg
    call logger('ERROR: '//msg)
  end subroutine

! Fail message and incrementing the module global TESTS_FAILED
  subroutine test_fail_msg(msg)
    character(len=*), optional :: msg
    TESTS_FAILED=TESTS_FAILED+1
    if (present(msg)) then
      call elogger('Test '//trim(adjustl(i_to_s(TESTS_RUN)))//': '//msg)
    else
      call elogger('Test '//trim(adjustl(i_to_s(TESTS_RUN))))
    end if
  end subroutine


end module

