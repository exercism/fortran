module eliuds_eggs

  implicit none

contains

! Just a cheat implementation at this stage, for validation
  integer function eggCount(number)
    integer :: number

    eggCount = popcnt(number)
  end function

end module
