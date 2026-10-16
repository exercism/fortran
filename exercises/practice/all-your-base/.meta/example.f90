module all_your_base
  implicit none

contains

  ! Convert digits in inputBase to digits in outputBase.
  ! Returns [-1] if either base is < 2 or any digit is out of range.
  function rebase(digits, inputBase, outputBase) result(res)
    integer, dimension(:), intent(in) :: digits
    integer, intent(in) :: inputBase, outputBase
    integer, dimension(:), allocatable :: res
    integer :: number, i

    if (inputBase < 2 .or. outputBase < 2) then
      res = [-1]
      return
    end if
    if (any(digits < 0 .or. digits >= inputBase)) then
      res = [-1]
      return
    end if

    number = 0
    do i = 1, size(digits)
      number = number * inputBase + digits(i)
    end do

    if (number == 0) then
      res = [0]
      return
    end if

    allocate(res(0))
    do while (number > 0)
      res = [mod(number, outputBase), res]
      number = number / outputBase
    end do
  end function

end module
