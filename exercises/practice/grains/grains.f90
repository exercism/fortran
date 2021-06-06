
module grains

  implicit none

contains

  ! Using double precision return type instead of int to avoid overflow in int
  double precision function square(nr)
    integer :: nr
    square = -1.d0
  end function

end module
