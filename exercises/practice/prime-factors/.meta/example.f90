module prime_factors
  use, intrinsic :: iso_fortran_env, only: int64
  implicit none

contains

  function factors(value) result(res)
    integer(int64), intent(in) :: value
    integer(int64), dimension(:), allocatable :: res
    integer(int64) :: n, d

    allocate(res(0))
    n = value
    d = 2
    do while (d * d <= n)
      do while (mod(n, d) == 0)
        res = [res, d]
        n = n / d
      end do
      d = d + 1
    end do
    if (n > 1) res = [res, n]
  end function factors

end module prime_factors
