
module triangle
  implicit none

  contains

  logical function equilateral(tria)
    integer,dimension(3) :: tria
    equilateral = .false.
  end function

end module
