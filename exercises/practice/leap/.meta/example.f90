module leap
  implicit none

contains

  pure logical function is_leap_year(year)
    integer, intent(in) :: year

    is_leap_year = is_div(year, 4) &
        & .AND. .NOT. is_div(year, 100) &
        & .OR. is_div(year, 400)
  end function

  pure logical function is_div(a, b)
    integer, intent(in) :: a, b

    is_div = 0 == modulo(a, b)
  end function

end module

