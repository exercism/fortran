module bob
  implicit none

  character(len=1), parameter :: CARRIAGE_RETURN_CHAR = char(13)
  character(len=1), parameter :: NEWLINE_CHAR = char(10)
  character(len=1), parameter :: TAB_CHAR = char(9)

contains
  function is_uppercase(str)
    logical :: is_uppercase
    character(len=*),intent(in) :: str
    character :: chr
    integer :: i
    is_uppercase = .FALSE.
    do i = 1,len_trim(str)
      chr = str(i:i)
      if (chr >= 'a' .AND. chr <= 'z') then
        is_uppercase = .FALSE.
        return
      else if (chr >= 'A' .AND. chr <= 'Z') then
        is_uppercase = .TRUE.
      end if
    end do
  end function is_uppercase

  function is_question(str)
    logical :: is_question
    character(*) :: str
    character :: chr
    integer :: i
    do i = len(str), 1, -1
      chr = str(i:i)
      if (chr /= ' ' .and. chr /= TAB_CHAR .and. &
          chr /= NEWLINE_CHAR .and. chr /= CARRIAGE_RETURN_CHAR) then
        is_question = (chr .EQ. '?')
        return
      end if
    end do
    is_question = .false.
  end function is_question

  function is_blank(str)
    logical :: is_blank
    character(*) :: str
    character :: chr
    integer :: i
    is_blank = .TRUE.
    do i = 1, len(str)
      if (chr /= ' ' .and. chr /= TAB_CHAR .and. &
          chr /= NEWLINE_CHAR .and. chr /= CARRIAGE_RETURN_CHAR) then
        is_blank = .FALSE.
        return
      end if
    end do
  end function is_blank

  function hey(statement)
    character(100) :: hey
    character(len=*), intent(in) :: statement

    if ( is_uppercase(statement) .and.is_question(statement) ) then
      hey = "Calm down, I know what I'm doing!"
    else if ( is_uppercase(statement) ) then
      hey = 'Whoa, chill out!'
    else if ( is_question(statement) ) then
      hey = 'Sure.'
    else if ( is_blank(statement) ) then
      hey = 'Fine. Be that way!'
    else
      hey = 'Whatever.'
    end if

  end function hey
end module bob
