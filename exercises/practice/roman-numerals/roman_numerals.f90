module roman_numerals
  implicit none

contains

  function roman(num) result(s)
    integer, value :: num
    character(15) :: s

    write(s, *) num ! Replace this line in your implementation
  end function roman

end module roman_numerals
