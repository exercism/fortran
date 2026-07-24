module largest_series_product

  implicit none
contains

  integer function largestProduct(strDigits, span)
    character(len=*), intent(in) :: strDigits
    integer, intent(in) :: span
    integer :: digitsLength, spanProduct, i, digit
    integer, dimension(52) :: intDigits

    if (span == 0) then
      largestProduct = 1
      return
    end if

    digitsLength = len_trim(strDigits)
    if (digitsLength == 0 .or. span < 0.or. span > digitsLength) then
      largestProduct = -1
      return
    end if

    intDigits = 1
    do i = 1, digitsLength
      digit = ichar(strDigits(i:i)) - ichar('0')
      if (digit < 0 .or. digit > 9) then
        largestProduct = -1
        return
      end if

      intDigits(i) = digit
    end do

    largestProduct = 0
    do i = 1, digitsLength - span + 1
      spanProduct = product(intDigits(i:(i + span - 1)))
      if (spanProduct > largestProduct) largestProduct = spanProduct
    end do
  end function

end module
