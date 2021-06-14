module leap
  implicit none

contains

  logical function is_leap_year(year)
    integer :: year

    is_leap_year = .true.
  end function

end module

