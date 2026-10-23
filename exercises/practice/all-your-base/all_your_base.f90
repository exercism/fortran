module all_your_base
  implicit none

contains

  function rebase(digits, inputBase, outputBase) result(res)
    integer, dimension(:), intent(in) :: digits
    integer, intent(in) :: inputBase, outputBase
    integer, dimension(:), allocatable :: res

    res = [digits, inputBase, outputBase] ! Replace this line in your implementation
  end function rebase

end module all_your_base
