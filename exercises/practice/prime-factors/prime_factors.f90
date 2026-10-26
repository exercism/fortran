module prime_factors
  use, intrinsic :: iso_fortran_env, only: int64
  implicit none

contains

  function factors(value) result(res)
    integer(int64), intent(in) :: value
    integer(int64), dimension(:), allocatable :: res

    res = [value] ! Replace this line in your implementation
  end function factors

end module prime_factors
