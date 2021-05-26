
module armstrong_numbers
  implicit none
contains

  logical function isArmstrongNumber(i)
    integer, intent(in) :: i
    
    isArmstrongNumber = .false.

  end function

end module
