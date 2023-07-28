module sieve
  implicit none

contains

  function primes(limit) result(array)
    integer, intent(in) :: limit
    integer, allocatable :: array(:)

    array = [limit] ! Replace this line with your implementation
  end function primes

end module sieve
