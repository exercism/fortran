module saddle_points
  implicit none

  type :: point_t
    integer :: row
    integer :: column
  end type point_t

contains

  function saddlePoints(matrix) result(points)
    integer, intent(in) :: matrix(:, :)
    type(point_t), allocatable :: points(:)

    ! Replace the following line in your implementation
    points = [point_t(row = size(matrix), column = size(matrix))]
  end function saddlePoints

end module saddle_points
