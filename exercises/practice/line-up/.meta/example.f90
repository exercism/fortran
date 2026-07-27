module line_up
  implicit none
contains

  function lineUp(name, number)
    character(len=*), intent(in) :: name
    integer, intent(in) :: number
    character(len=:), allocatable :: lineUp
    character(len=10) :: buffer

    write(buffer, '(I0)') number
    lineUp = name // ", you are the " // trim(buffer) // ending(number) // " customer we serve today. Thank you!"

  end function

  function ending(number)
    integer, intent(in) :: number
    character(len=2) :: ending
    integer :: last_digit
    character(len=2), dimension(3) :: specials

    if (any([11, 12, 13] == mod(number, 100))) then
      ending = "th"
      return
    end if

    last_digit = mod(number, 10)
    specials = ["st", "nd", "rd"]
    if (any([1, 2, 3] == last_digit)) then
      ending = specials(last_digit)
      return
    end if
    ending = "th"
  end function

end module
