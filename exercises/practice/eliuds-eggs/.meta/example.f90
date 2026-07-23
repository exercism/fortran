module eliuds_eggs

  implicit none

contains

! A cheat implementation, for quick CI validation
  integer function eggCount(number)
    integer :: number

    eggCount = popcnt(number)
  end function

! Doing it "properly"
  ! integer function eggCount(number)
  !   integer :: number, remaining

  !   eggCount = 0
  !   remaining = number
  !   do while (remaining > 0)
  !     eggCount = eggCount + iand(remaining, 1)
  !     remaining = shiftr(remaining, 1)
  !   end do

  ! end function

end module
