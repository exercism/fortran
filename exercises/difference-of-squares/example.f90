module DifferenceOfSquares
  implicit none
 contains
  integer function square_of_sum(n)
    implicit none
    integer :: i,n

    square_of_sum = 0

    do i = 1,n
      square_of_sum = square_of_sum + i
    end do

    square_of_sum = square_of_sum * square_of_sum
  end function 

  integer function sum_of_squares(n)
    implicit none
    integer :: i, n

    sum_of_squares = 0

    do i = 1,n
      sum_of_squares = sum_of_squares + i**2
    end do

  end function 

  integer function difference_of_squares(n)
    implicit none
    integer :: n

    difference_of_squares = square_of_sum(n) - sum_of_squares(n)
  end function 

end module DifferenceOfSquares
