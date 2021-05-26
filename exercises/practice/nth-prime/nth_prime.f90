module nth_prime
  implicit none
contains

  ! get nth prime
  integer function prime(n)
    integer, intent(in) :: n
    prime = -1
  end function

end module
