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
  character(len=*), parameter :: TEST_JSON_FILE = "results.json"
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
  subroutine write_json_success( test_description )
    ! -------------------------------
    character(len=*), intent(in) :: test_description
    ! -------------------------------
    character(len=MAX_STRING_LEN) :: test_info
    
    if (.not. exercism_fortran_json_env_is_set() ) then
      return
    end if
    
    call open_and_write_json_test_header()

    test_info = 'Test '//trim(adjustl(i_to_s(TESTS_RUN)))//': '//trim(test_description)

    write(TEST_JSON_FILE_UNIT,*) '    {'
    write(TEST_JSON_FILE_UNIT,*) '      "name"     : "'//trim(test_info)//'",'
    write(TEST_JSON_FILE_UNIT,*) '      "test_code": "'//trim(test_info)//'",'
    write(TEST_JSON_FILE_UNIT,*) '      "status"   : "pass"'
    write(TEST_JSON_FILE_UNIT,*) '    }'
  end subroutine

  !------------------------------------------------------------------
  subroutine write_json_fail( test_description, msg )
    ! -------------------------------
    character(len=*), intent(in) :: test_description
    character(len=*), intent(in) :: msg
    ! -------------------------------
    character(len=MAX_STRING_LEN) :: test_info

    if (.not. exercism_fortran_json_env_is_set() ) then
      return
    end if

    call open_and_write_json_test_header()

    test_info = 'Test '//trim(adjustl(i_to_s(TESTS_RUN)))//': '//trim(test_description)

    write(TEST_JSON_FILE_UNIT,*)   '    {'
    write(TEST_JSON_FILE_UNIT,*)   '      "name"     : "'//trim(test_info)//'",'
    write(TEST_JSON_FILE_UNIT,*)   '      "test_code": "'//trim(test_info)//'",'
    write(TEST_JSON_FILE_UNIT,*)   '      "status"   : "fail",'
    write(TEST_JSON_FILE_UNIT,*)   '      "message"  : "'//trim(msg)//'"'
    write(TEST_JSON_FILE_UNIT,*)   '    }'

  end subroutine


  !------------------------------------------------------------------
  subroutine open_and_write_json_test_header()
    ! -------------------------------
    logical :: exist
    ! -------------------------------

    if (.not. exercism_fortran_json_env_is_set() ) then
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
  end subroutine 

  !------------------------------------------------------------------
  subroutine close_and_write_json_footer()

    if ( .not. exercism_fortran_json_env_is_set() ) then
      return 
    end if

    open(unit=TEST_JSON_FILE_UNIT, file=TEST_JSON_FILE, status="old", position="append", action="write")
    write(TEST_JSON_FILE_UNIT,*)   '  ],'
    write(TEST_JSON_FILE_UNIT,*)   '  "version": 2,'
    if (TESTS_FAILED==0) then
      write(TEST_JSON_FILE_UNIT,*) '  "status" : "pass"'
    else
      write(TEST_JSON_FILE_UNIT,*) '  "status" : "fail",'
      ! only write message on fail:
      write(TEST_JSON_FILE_UNIT,*) '  "message": "Test summary: '// &
      & trim(adjustl(i_to_s(TESTS_FAILED)))//' of '//trim(adjustl(i_to_s(TESTS_RUN)))//' tests failed"'
    end if
    write(TEST_JSON_FILE_UNIT,*)   '}'
    close(TEST_JSON_FILE_UNIT)

  end subroutine

  !------------------------------------------------------------------
  logical function exercism_fortran_json_env_is_set()
    character(len=MAX_STRING_LEN) :: exercism_fortran_json
    exercism_fortran_json_env_is_set = .false.
    call get_environment_variable("EXERCISM_FORTRAN_JSON", exercism_fortran_json)
    if (trim(exercism_fortran_json) == '1') then
      exercism_fortran_json_env_is_set = .true.
    end if
  end function

  !------------------------------------------------------------------
  subroutine test_report()

    call logger('Test summary: '//trim(adjustl(i_to_s(TESTS_FAILED)))//' of '//trim(adjustl(i_to_s(TESTS_RUN)))//' tests failed')
    call close_and_write_json_footer()
    if (TESTS_FAILED==0) then
      STOP 0
    else
      STOP 1
    endif
  end subroutine

  !------------------------------------------------------------------
  subroutine assert_equal_bool(e_bool,i_bool,test_description)
    ! -------------------------------
    logical, intent(in) :: e_bool, i_bool
    character(len=*), intent(in) :: test_description
    ! -------------------------------
    logical :: assert_test
    character(len=MAX_STRING_LEN) :: expected_msg

    TESTS_RUN=TESTS_RUN+1
    assert_test = i_bool .eqv. e_bool
    if (.not. assert_test) then
      call test_fail_msg(test_description)
      expected_msg = get_expected_msg( b_to_s(e_bool), b_to_s(i_bool))
      call elogger(expected_msg)
      call write_json_fail( test_description, expected_msg)
    else
      call write_json_success( test_description)
    endif
  end subroutine

  !------------------------------------------------------------------
  subroutine assert_equal_str(estr,istr,test_description)
    ! -------------------------------
    character(len=*), intent(in) :: estr,istr
    character(len=*), intent(in) :: test_description
    ! -------------------------------
    logical :: assert_test
    character(len=MAX_STRING_LEN) :: expected_msg

    TESTS_RUN=TESTS_RUN+1
    assert_test = istr == estr
    if (.not. assert_test) then
      call test_fail_msg(test_description)
      expected_msg = get_expected_msg(estr, istr)
      call elogger(expected_msg)
      call write_json_fail( test_description, expected_msg)
    else
      call write_json_success( test_description)
    endif
  end subroutine

  !------------------------------------------------------------------
  subroutine assert_equal_int(e_int,i_int,test_description)
    ! -------------------------------
    integer, intent(in) :: e_int,i_int
    character(len=*), intent(in) :: test_description
    ! -------------------------------
    logical :: assert_test
    character(len=MAX_STRING_LEN) :: expected_msg

    TESTS_RUN=TESTS_RUN+1
    assert_test = i_int == e_int
    if (.not. assert_test) then
      call test_fail_msg(test_description)
      expected_msg = get_expected_msg(adjustl(i_to_s(e_int)),adjustl(i_to_s(i_int)))
      call elogger(expected_msg)
      call write_json_fail( test_description, expected_msg)
    else
      call write_json_success( test_description)
    endif
  end subroutine

  !------------------------------------------------------------------
  subroutine assert_equal_int_arr(e_int_arr, i_int_arr, test_description)
    ! -------------------------------
    integer, dimension(:), intent(in) :: e_int_arr, i_int_arr
    character(len=*), intent(in) :: test_description
    ! -------------------------------
    logical :: assert_test
    character(len=MAX_STRING_LEN) :: expected_msg
    integer :: i

    TESTS_RUN=TESTS_RUN+1
    assert_test = .false.
    assert_test = size(e_int_arr) == size(i_int_arr)
    expected_msg = ''
    if (.not. assert_test) then
      call test_fail_msg(test_description)
      call elogger('Arrays are not the same size!')
      expected_msg = get_expected_msg( adjustl(ia_to_s(e_int_arr)), adjustl(ia_to_s(i_int_arr)))
      call elogger( expected_msg )
      call write_json_fail( test_description, expected_msg)

    else
      do i=1,size(e_int_arr)
        assert_test = i_int_arr(i) == e_int_arr(i)
        if (.not. assert_test) exit
      enddo
    endif
    if (.not. assert_test) then
      call test_fail_msg(test_description)
      expected_msg = get_expected_msg(adjustl(ia_to_s(e_int_arr)), adjustl(ia_to_s(i_int_arr)))
      call elogger( expected_msg )
      call write_json_fail( test_description, expected_msg)
    else
      call write_json_success( test_description)
    endif
  end subroutine

  !------------------------------------------------------------------
  subroutine assert_equal_dble(e_dble,i_dble,test_description)
    ! -------------------------------
    double precision, intent(in) :: e_dble,i_dble
    character(len=*), intent(in) :: test_description
    ! -------------------------------
    logical :: assert_test
    character(len=MAX_STRING_LEN) :: expected_msg

    TESTS_RUN=TESTS_RUN+1
    assert_test = dabs(i_dble - e_dble) < TOL
    if (.not. assert_test) then
      call test_fail_msg(test_description)
      expected_msg  = get_expected_msg( adjustl(d_to_s(e_dble)), adjustl(d_to_s(i_dble)))
      call elogger(expected_msg)
      call write_json_fail( test_description, expected_msg)
    else
      call write_json_success( test_description)
    endif

  end subroutine

  !------------------------------------------------------------------
  subroutine assert_equal_real(e_real,i_real,test_description)
    ! -------------------------------
    real, intent(in) :: e_real,i_real
    character(len=*), intent(in) :: test_description
    ! -------------------------------
    logical :: assert_test
    character(len=MAX_STRING_LEN) :: expected_msg

    TESTS_RUN=TESTS_RUN+1
    assert_test = abs(i_real - e_real) < TOL
    if (.not. assert_test) then
      call test_fail_msg(test_description)
      expected_msg = get_expected_msg(adjustl(r_to_s(e_real)), adjustl(r_to_s(i_real)))
      call elogger(expected_msg)
      call write_json_fail( test_description, expected_msg)
    else
      call write_json_success( test_description)
    endif

  end subroutine


!------------------------------------------------------------------
! utilities
!------------------------------------------------------------------
function get_expected_msg(expected, but_got)
  character(len=MAX_STRING_LEN) :: get_expected_msg
  character(len=*) :: expected
  character(len=*) :: but_got
  get_expected_msg  = 'Expected < '//trim(expected)//' > but got < '&
      & //trim(but_got)//' >'
end function 

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
    character(len=MAX_STRING_LEN) :: b_to_s
    if (b) then
      b_to_s='True'
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
    write(*,*) trim(msg)
  end subroutine

! Error logger
  subroutine elogger(msg)
    character(len=*) :: msg
    call logger('ERROR: '//trim(msg))
  end subroutine

! Fail message and incrementing the module global TESTS_FAILED
  subroutine test_fail_msg(msg)
    character(len=*) :: msg
    TESTS_FAILED=TESTS_FAILED+1
    call elogger('Test '//trim(adjustl(i_to_s(TESTS_RUN)))//': '//msg)
  end subroutine


end module

