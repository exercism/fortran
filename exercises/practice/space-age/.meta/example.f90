
module orbital_constants
  implicit none
  
  ! Earth: orbital period 1.0 Earth years, 365.25 Earth days, or 31557600 seconds
  double precision, parameter, private :: earth_year_seconds = 31557600.d0
  
  ! A planet's orbit as measured in Earth years
  double precision, parameter, private :: mercury_earth_years = 0.2408467d0
  double precision, parameter, private :: venus_earth_years = 0.61519726d0
  double precision, parameter, private :: mars_earth_years = 1.8808158d0
  double precision, parameter, private :: jupiter_earth_years = 11.862615d0
  double precision, parameter, private :: saturn_earth_years = 29.447498d0
  double precision, parameter, private :: uranus_earth_years = 84.016846d0
  double precision, parameter, private :: neptune_earth_years = 164.79132d0

end module orbital_constants

module space_age
  use orbital_constants
  implicit none
contains

  double precision function age_in_years(planet, seconds)
    character(len=*), intent(in) :: planet
    double precision, intent(in) :: seconds
    double precision, intent(out) :: age_in_years = 0.d0

    ! A multiplier for a number of Earth years for the given planet
    double precision :: n_earth_years = 0.d0
    
    select case (planet)
    case ("Mercury")
      n_earth_years = mercury_earth_years
    case ("Venus")
      n_earth_years = venus_earth_years
    case ("Earth")
      n_earth_years = 1.d0
    case ("Mars")
      n_earth_years = mars_earth_years
    case ("Jupiter")
      n_earth_years = jupiter_earth_years
    case ("Saturn")
      n_earth_years = saturn_earth_years
    case ("Uranus")
      n_earth_years = uranus_earth_years
    case ("Neptune")
      n_earth_years = neptune_earth_years
    case default
      write(*,*) 'ERROR: unknown planet: '//trim(planet)
    end select
    
    age_in_years = seconds / earth_year_seconds / n_earth_years

  end function

end module
