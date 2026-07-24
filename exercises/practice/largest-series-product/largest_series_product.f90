module largest_series_product

  implicit none
contains

  integer function largestProduct(strDigits, span)
    character(len=*), intent(in) :: strDigits
    integer, intent(in) :: span

    largestProduct = -1 ! Replace this line with your implementation
  end function

end module
