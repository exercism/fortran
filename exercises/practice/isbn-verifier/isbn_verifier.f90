module isbn_verifier
  implicit none

contains

  function isValid(isbn) result(valid)
    character(*), intent(in) :: isbn
    logical :: valid

    valid = isbn == "123" ! Replace this line with your implementation
  end function isValid

end module isbn_verifier
