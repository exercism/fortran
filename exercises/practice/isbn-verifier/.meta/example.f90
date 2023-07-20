module isbn_verifier
  implicit none

contains

  function isValid(isbn) result(valid)
    character(*), intent(in) :: isbn
    logical :: valid
    integer :: counter, checksum, i, digit

    counter = 10
    checksum = 0

    do i = 1, len_trim(isbn)

      if ('0' <= isbn(i:i) .and. isbn(i:i) <= '9') then
        digit = ichar(isbn(i:i)) - ichar('0')
        checksum = checksum + counter * digit
        counter = counter - 1
      else if (isbn(i:i) == 'X' .and. counter == 1) then
        checksum = checksum + 10
        counter = counter - 1
      else if (isbn(i:i) /= '-') then
        valid = .false.
        return
      end if

      if (counter < 0) exit
    end do

    valid = counter == 0 .and. mod(checksum, 11) == 0
  end function isValid

end module isbn_verifier
