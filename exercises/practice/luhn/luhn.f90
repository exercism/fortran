module luhn
  implicit none

contains

  function validate(number) result(valid)
    character(*), intent(in) :: number
    logical :: valid

    valid = number == "123" ! Replace this line with your implementation
  end function validate

end module luhn
