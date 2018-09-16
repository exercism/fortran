module hamming
  implicit none
contains

  integer function distance(strand1, strand2 )
      character(len=*), intent(in) :: strand1, strand2
      integer :: i
      logical :: compute

      distance = -1

      if ( len(strand1) .NE. len(strand2) ) then
          return
      end if

      distance = 0
      do i = 1,len(strand1)
        if (strand1(i:i) .NE. strand2(i:i)) then
          distance = distance + 1
        end if
      end do
  end function 
  
end module hamming
