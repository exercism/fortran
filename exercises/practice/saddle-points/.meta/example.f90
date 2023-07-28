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
    integer :: n_points, i, j, &
      rmax(size(matrix, 1)), &
      cmin(size(matrix, 2))
    type(point_t) :: temp_points(size(matrix))

    rmax = maxval(matrix, dim=2)
    cmin = minval(matrix, dim=1)
    n_points = 0

    do j = 1, size(cmin)
      do i = 1, size(rmax)
        if (cmin(j) == rmax(i)) then
          n_points = n_points + 1
          temp_points(n_points) = point_t(row = i, column = j)
        end if
      end do
    end do

    points = temp_points(1:n_points)
  end function saddlePoints

end module saddle_points
