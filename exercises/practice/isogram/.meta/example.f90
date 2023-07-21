module isogram
  implicit none

contains

  function isIsogram(phrase) result(no_repeats)
    character(len=*), intent(in) :: phrase
    logical :: no_repeats
    logical :: seen(26)
    integer :: i, letter

    seen = .false.

    do i = 1, len_trim(phrase)
      select case (phrase(i:i))
       case ('a':'z')
        letter = ichar(phrase(i:i)) - ichar('a') + 1
       case ('A':'Z')
        letter = ichar(phrase(i:i)) - ichar('A') + 1
       case ('-')
        cycle
       case (' ')
        cycle
       case default
        no_repeats = .false.
        return
      end select

      if (seen(letter)) then
        no_repeats = .false.
        return
      end if

      seen(letter) = .true.
    end do

    no_repeats = .true.
  end function isIsogram

end module isogram
