
module grains

  implicit none

contains

  ! Using double precision return type instead of int to avoid overflow in int
  double precision function square(n)
    integer :: n
    square = -1.d0
    if (n>=1 .and. n<=64) then
      square = 2.d0**(n-1)
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
