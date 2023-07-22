module sieve
  implicit none

contains

  function primes(limit) result(array)
    integer, intent(in) :: limit
    integer, allocatable :: array(:)
    logical :: composites(limit)
    integer :: temp(limit), n_primes, i, j

    composites = .false.
    n_primes = 0

    do i = 2, limit
      if (composites(i)) cycle

      n_primes = n_primes + 1
      temp(n_primes) = i

      do j = i ** 2, limit, i
        composites(j) = .true.
      end do
    end do

    array = temp(1:n_primes)
  end function primes

end module sieve
