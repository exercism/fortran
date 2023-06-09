module reverse_string
  implicit none
contains

  function reverse(input) result(reversed)
    character(*), intent(in) :: input
    character(len=len(input)) :: reversed
    integer :: length, i, idx

    length = len(input)

    do i = 1, length
      idx = length - i + 1
      reversed(i:i) = input(idx:idx)
    end do
  end function

end module
