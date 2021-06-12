
module grains

  implicit none

contains

  ! Using double precision return type instead of int to avoid overflow in int
  double precision function square(n)
    integer :: n
    square = -1.d0
  end function

  double precision function total()
    total = -1.d0
  end function

end module
