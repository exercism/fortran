module game_of_life
  implicit none
contains

  function tick(matrix) result(next)
    integer, dimension(:,:), intent(in) :: matrix
    integer :: next(size(matrix, 1), size(matrix, 2))

    ! implement me!
    next = matrix
  end function
end module
