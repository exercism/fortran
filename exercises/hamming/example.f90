module hamming

implicit none
contains

  function compute(strand1, strand2, distance)
      character(*) :: strand1, strand2
      integer :: distance, i
      logical :: compute

      distance = 0
      compute = .true.

      if ( len(strand1) .NE. len(strand2) ) then
          compute = .false.
          return
      end if

      do i = 1,len(strand1)
        if (strand1(i:i) .NE. strand2(i:i)) then
          distance = distance + 1
        end if

      end do

  end function compute
end module hamming
