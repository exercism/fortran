module darts
  implicit none

contains

  function score(x, y) result(points)
    real, intent(in):: x, y
    integer :: points

    points = int(x + y) ! Replace this line with your implementation
  end function score

end module darts
