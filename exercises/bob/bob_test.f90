
module bob_test
  implicit none
contains
  function random_string(length, begin_char, end_char)
    integer :: length, r, i
    character(length) :: random_string
    logical :: uppercase
    integer :: base, ending
    character :: begin_char, end_char

    base = ichar(begin_char)
    ending = ichar(end_char)

    do i = 1,length
      r = rand(0)*(ending-base)
      random_string(i:i) = char(base + r)
    end do
  end function random_string

  function random_shouting(length)
    integer :: length
    character(length) :: random_shouting
    random_shouting = random_string(length-1, 'A', 'Z')
    random_shouting(length:length) = '!'
  end function random_shouting

  function random_question(length)
    integer :: length
    character(length) :: random_question
    random_question = random_string(length-1, 'a', 'z')
    random_question(length:length) = '?'
  end function random_question


  subroutine assert_msg(is_ok, msg)
    logical, intent(in)  :: is_ok
    character(len=*), optional, intent(in) :: msg
    if ( .not. is_ok ) then
      if (present(msg)) then
        call elogger(msg)
      end if 
      call elogger('Assertion failed')
    end if 
  end subroutine
    
    
  subroutine assert_equal(input_str,expected_str)
    character(len=*), intent(in) :: input_str, expected_str
    character(len=1024) ::  msg 
    logical isEqual
    isEqual = input_str == expected_str
    if(.not. isEqual) then
      call assert_msg(isEqual, 'Strings do not match. Got '// &
        trim(input_str)//' but expected '//trim(expected_str))
    end if
  end subroutine 

  ! logger routine, in case other than stdout is needed
  subroutine logger(msg)
    character(len=*), intent(in) :: msg 
    write(*,*) msg
  end subroutine 
  subroutine elogger(msg)
    character(len=*), intent(in) :: msg 
    call logger('ERROR '//msg)
  end subroutine 
end module

program test_main
  use bob
  use bob_test
  call assert_equal( 'Whatever.' , hey('Tom-ay-to, tomaaaah-to.') )
end program



