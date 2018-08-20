module bob
implicit none
contains
  function is_uppercase(str)
    logical :: is_uppercase
    character(*) :: str
    character :: chr
    integer :: i

    is_uppercase = .FALSE.

    do i = 1,len(str)
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

    chr = str(len(str):len(str))
    is_question = (chr .EQ. '?')
  end function is_question

  function is_blank(str)
    logical :: is_blank
    character(*) :: str
    integer :: i
    is_blank = .TRUE.

    do i = 1,len(str)
      if ( str(i:i) .NE. ' ' ) then
        is_blank = .FALSE.
        return
      end if
    end do

  end function is_blank

  function hey(statement)
    character(100) :: hey
    character(*) :: statement

    if ( is_uppercase(statement) ) then
      hey = 'Whoa chill out!'
    else if ( is_question(statement) ) then
      hey = 'Sure.'
    else if ( is_blank(statement) ) then
      hey = 'Fine. Be that way!'
    else
      hey = 'Whatever.'
    end if

  end function hey
end module bob
