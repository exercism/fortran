module game_of_life
  implicit none
  private
  public :: tick
contains

  function tick(matrix) result(next)
    integer, dimension(:,:), intent(in) :: matrix
    integer :: next(size(matrix, 1), size(matrix, 2))
    integer :: nrows, ncols, r, c, n

    nrows = size(matrix, 1)
    ncols = size(matrix, 2)
    do c = 1, ncols
      do r = 1, nrows
        ! live cells in the (edge-clipped) 3x3 neighbourhood, excluding the cell itself
        n = sum(matrix(max(1, r-1):min(nrows, r+1), max(1, c-1):min(ncols, c+1))) - matrix(r, c)
        if (n == 3 .or. (n == 2 .and. matrix(r, c) == 1)) then
          next(r, c) = 1
        else
          next(r, c) = 0
        end if
      end do
    end do
  end function
end module
