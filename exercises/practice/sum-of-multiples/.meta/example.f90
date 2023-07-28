module sum_of_multiples
  implicit none

contains

  function sum_multiples(factors, limit) result(res)
    integer, intent(in) :: factors(:), limit
    integer :: res
    integer :: i, j, factor, multiples(limit - 1)

    multiples = 0

    do i = 1, size(factors)
      factor = factors(i)
      if (factor == 0) cycle

      do j = factor, limit - 1, factor
        multiples(j) = j
      end do
    end do

    res = sum(multiples)
  end function sum_multiples

end module sum_of_multiples
