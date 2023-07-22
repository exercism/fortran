module sum_of_multiples
  implicit none

contains

  function sum_multiples(factors, limit) result(res)
    integer, intent(in) :: factors(:), limit
    integer :: res

    res = sum(factors) - limit ! Replace this line with your implementation
  end function sum_multiples

end module sum_of_multiples
