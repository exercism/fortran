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

  ! output file for fortran-test-runner
  ! only write if ENV variable
  ! EXERCISM_FORTRAN_JSON=1
  character(len=*), parameter :: TEST_JSON_FILE = "result.json"
  integer, parameter :: TEST_JSON_FILE_UNIT = 12

  interface assert_equal
    module procedure assert_equal_str
    module procedure assert_equal_int
    module procedure assert_equal_int_arr
    module procedure assert_equal_dble
    module procedure assert_equal_real
    module procedure assert_equal_bool
  end interface

contains

  !------------------------------------------------------------------
  subroutine write_json(assert_test, msg)
    ! -------------------------------
    logical :: assert_test
    character(len=*), intent(in), optional :: msg
    ! -------------------------------
    character(len=MAX_STRING_LEN) :: exercism_fortran_json
    character(len=MAX_STRING_LEN) :: test_name
    logical :: exist

    call get_environment_variable("EXERCISM_FORTRAN_JSON", exercism_fortran_json)
    if (trim(exercism_fortran_json) /= '1') then
      return
    end if
    inquire(file=TEST_JSON_FILE, exist=exist)
    if (exist) then
      open(unit=TEST_JSON_FILE_UNIT, file=TEST_JSON_FILE, status="old", position="append", action="write")
    else
      open(unit=TEST_JSON_FILE_UNIT, file=TEST_JSON_FILE, status="new", action="write")
      ! write header
      write(TEST_JSON_FILE_UNIT,*) '{'
      write(TEST_JSON_FILE_UNIT,*) '  "tests": ['
    end if
    if (TESTS_RUN>1) then
      write(TEST_JSON_FILE_UNIT,*) '    ,'
    end if
    test_name = 'Test '//trim(adjustl(i_to_s(TESTS_RUN)))//':'
    if (present(msg)) then
      write(TEST_JSON_FILE_UNIT,*) '    { "name"  : "'//trim(test_name)//' '//trim(msg)//'",'
    else
      write(TEST_JSON_FILE_UNIT,*) '    { "name"  : "'//trim(test_name)//'",'
    end if
    if (assert_test) then
      write(TEST_JSON_FILE_UNIT,*) '      "status": "pass" }'
    else
      write(TEST_JSON_FILE_UNIT,*) '      "status": "fail" }'
    end if

  end subroutine


  !------------------------------------------------------------------
  subroutine test_report()
    logical :: exist
    character(len=MAX_STRING_LEN) :: exercism_fortran_json

    call logger('Test summary: '//trim(adjustl(i_to_s(TESTS_FAILED)))//' of '//trim(adjustl(i_to_s(TESTS_RUN)))//' tests failed')
    call get_environment_variable("EXERCISM_FORTRAN_JSON", exercism_fortran_json)
    inquire(file=TEST_JSON_FILE, exist=exist)
    if (trim(exercism_fortran_json) == '1' .and. exist) then
      open(unit=TEST_JSON_FILE_UNIT, file=TEST_JSON_FILE, status="old", position="append", action="write")
      write(TEST_JSON_FILE_UNIT,*)   '  ],'
      write(TEST_JSON_FILE_UNIT,*)   '  "version": 2,'
      if (TESTS_FAILED==0) then
        write(TEST_JSON_FILE_UNIT,*) '  "status": "pass"'
      else
        write(TEST_JSON_FILE_UNIT,*) '  "status": "fail"'
      end if
      write(TEST_JSON_FILE_UNIT,*)   '}'
    end if
    if (TESTS_FAILED==0) then
      STOP 0
    else
      STOP 1
    endif
  end subroutine

  !------------------------------------------------------------------
  subroutine assert_equal_bool(e_bool,i_bool,msg)
    ! -------------------------------
    logical, intent(in) :: e_bool, i_bool
    character(len=*), intent(in), optional :: msg
    ! -------------------------------
    logical :: assert_test

    TESTS_RUN=TESTS_RUN+1
    assert_test = i_bool .eqv. e_bool
    if (.not. assert_test) then
      call test_fail_msg(msg)
      call elogger('Expected "'//trim(b_to_s(e_bool))//'" but got "'//trim(b_to_s(i_bool))//'"')
    endif
    call write_json(assert_test, msg)
  end subroutine

  !------------------------------------------------------------------
  subroutine assert_equal_str(estr,istr,msg)
    ! -------------------------------
    character(len=*), intent(in) :: estr,istr
    character(len=*), intent(in), optional :: msg
    ! -------------------------------
    logical :: assert_test
    TESTS_RUN=TESTS_RUN+1
    assert_test = istr == estr
    if (.not. assert_test) then
      call test_fail_msg(msg)
      call elogger('Expected "'//trim(estr)//'" but got "'//trim(istr)//'"')
    endif
    call write_json(assert_test, msg)
  end subroutine

  !------------------------------------------------------------------
  subroutine assert_equal_int(e_int,i_int,msg)
    ! -------------------------------
    integer, intent(in) :: e_int,i_int
    character(len=*), intent(in), optional :: msg
    ! -------------------------------
    logical :: assert_test

    TESTS_RUN=TESTS_RUN+1
    assert_test = i_int == e_int
    if (.not. assert_test) then
      call test_fail_msg(msg)
      call elogger('Expected "'//trim(adjustl(i_to_s(e_int)))//'" but got "' &
      & //trim(adjustl(i_to_s(i_int)))//'"' )
    endif
    call write_json(assert_test, msg)
  end subroutine

  !------------------------------------------------------------------
  subroutine assert_equal_int_arr(e_int_arr, i_int_arr, msg_arr)
    ! -------------------------------
    integer, dimension(:), intent(in) :: e_int_arr, i_int_arr
    character(len=*), intent(in) :: msg_arr
    ! -------------------------------
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
    call write_json(assert_test, msg_arr)
  end subroutine

  !------------------------------------------------------------------
  subroutine assert_equal_dble(e_dble,i_dble,msg)
    ! -------------------------------
    double precision, intent(in) :: e_dble,i_dble
    character(len=*), intent(in), optional :: msg
    ! -------------------------------
    logical :: assert_test
    TESTS_RUN=TESTS_RUN+1
    assert_test = dabs(i_dble - e_dble) < TOL
    if (.not. assert_test) then
      call test_fail_msg(msg)
      call elogger('Expected "'//trim(adjustl(d_to_s(e_dble)))//'" but got "'&
      & //trim(adjustl(d_to_s(i_dble)))//'"')
    endif
    call write_json(assert_test, msg)
  end subroutine

  !------------------------------------------------------------------
  subroutine assert_equal_real(e_real,i_real,msg)
    ! -------------------------------
    real, intent(in) :: e_real,i_real
    character(len=*), intent(in), optional :: msg
    ! -------------------------------
    logical :: assert_test
    TESTS_RUN=TESTS_RUN+1
    assert_test = abs(i_real - e_real) < TOL
    if (.not. assert_test) then
      call test_fail_msg(msg)
      call elogger('Expected "'//trim(adjustl(r_to_s(e_real)))//'" but got "'&
      & //trim(adjustl(r_to_s(i_real)))//'"')
    endif
    call write_json(assert_test, msg)
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

! Real to string
  function r_to_s(d)
    real, intent(in) :: d
    character(len=MAX_STRING_LEN) :: r_to_s
    write(r_to_s, *) d
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

