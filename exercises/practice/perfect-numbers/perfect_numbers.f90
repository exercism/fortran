
module perfect_numbers
  implicit none

contains

  character(len=9) function classify(num)
    integer, intent(in) :: num
    classify = "ERROR"
  end function

end module
