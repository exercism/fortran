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
! When used like below, the number of failed test is counted and summarized in 'test_report' routine.
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
  save
  public

  integer :: TESTS_RUN = 0
  integer :: TESTS_FAILED = 0
  integer, parameter :: MAX_STRING_LEN = 80
  double precision, parameter :: TOL = 1.0D-8

  interface assert_equal
    module procedure assert_equal_str
    module procedure assert_equal_int
    module procedure assert_equal_int_arr
    module procedure assert_equal_dble
    module procedure assert_equal_bool
  end interface
!  interface  assert_equal_int_arr
!    module procedure assert_equal_int_arr2
!  end interface

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
  subroutine assert_equal_int_arr(e_int_arr, i_int_arr, msg_arr)
    integer, dimension(:), intent(in) :: e_int_arr, i_int_arr
    character(len=*), intent(in) :: msg_arr
    logical :: assert_test
    integer :: i
    TESTS_RUN=TESTS_RUN+1
    assert_test = .false.
    assert_test = size(e_int_arr) == size(i_int_arr)
    if (.not. assert_test) then
      call test_fail_msg(msg_arr)
      call elogger('Arrays are not the same size!')
      call elogger('Expected "'//trim(adjustl(ia_to_s(e_int_arr)))//'" but got "' &
      & //trim(adjustl(ia_to_s(i_int_arr)))//'"' )
    else
      do i=1,size(e_int_arr)
        assert_test = i_int_arr(i) == e_int_arr(i)
        if (.not. assert_test) exit
      enddo
    endif
    if (.not. assert_test) then
      call test_fail_msg(msg_arr)
      call elogger('Expected "'//trim(adjustl(ia_to_s(e_int_arr)))//'" but got "' &
      & //trim(adjustl(ia_to_s(i_int_arr)))//'"' )
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
! Integer to string
  function i_to_s(i)
    integer, intent(in) :: i
    character(len=MAX_STRING_LEN) :: i_to_s
    write(i_to_s, *) i
  end function

! Integer array to string
  function ia_to_s(i)
    integer, dimension(:), intent(in) :: i
    character(len=MAX_STRING_LEN) :: ia_to_s
    write(ia_to_s, *) i
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

