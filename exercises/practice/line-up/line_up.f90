module line_up
  implicit none
contains

  function lineUp(name, number)
    character(len=*), intent(in) :: name
    integer, intent(in) :: number
    character(len=:), allocatable :: lineUp

    lineUp = "Implement me!"

  end function

end module
