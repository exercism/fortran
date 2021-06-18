
module space_age
  implicit none
contains

  double precision function age_in_years(planet, seconds)
    character(len=*), intent(in) :: planet
    double precision, intent(in) :: seconds
    
    age_in_years = 0.d0
    
  end function

end module
