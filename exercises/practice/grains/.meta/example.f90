
module grains

  implicit none

contains

  ! Using double precision return type instead of int to avoid overflow in int
  double precision function square(nr)
    integer :: nr
    square = -1.d0
    if (nr>=1 .and. nr<=64) then
      square = 2.d0**(nr-1)
    end if
  end function

  double precision function total()
    integer :: i
    total=0.d0
    do i=1,64
      total = total +square(i)
    end do
  end function

end module
