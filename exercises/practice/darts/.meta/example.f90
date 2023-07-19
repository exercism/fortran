module darts
   implicit none

contains

   function score(x, y) result(points)
      real, intent(in):: x, y
      integer :: points
      real :: dist

      dist = hypot(x, y)

      if (dist <= 1) then
         points = 10
      else if (dist <= 5) then
         points = 5
      else if (dist <= 10) then
         points = 1
      else
         points = 0
      end if
   end function score

end module darts
