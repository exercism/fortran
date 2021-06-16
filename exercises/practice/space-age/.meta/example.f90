
module space_age
  implicit none
contains

  double precision function age_in_years(planet, seconds)
    !Mercury: orbital period 0.2408467 Earth years
    !Venus: orbital period 0.61519726 Earth years
    !Earth: orbital period 1.0 Earth years, 365.25 Earth days, or 31557600 seconds
    !Mars: orbital period 1.8808158 Earth years
    !Jupiter: orbital period 11.862615 Earth years
    !Saturn: orbital period 29.447498 Earth years
    !Uranus: orbital period 84.016846 Earth years
    !Neptune: orbital period 164.79132 Earth years

    character(len=*) :: planet
    double precision :: seconds
    
    age_in_years = 0.d0
    
    select case (planet)
    case ("Mercury")
      !Mercury: orbital period 0.2408467 Earth years
      age_in_years = seconds/31557600.d0/0.2408467d0

    case ("Venus")
      !Venus: orbital period 0.61519726 Earth years
      age_in_years = seconds/31557600.d0/0.61519726d0

    case ("Earth")
      !Earth: orbital period 1.0 Earth years, 365.25 Earth days, or 31557600 seconds
      age_in_years = seconds/31557600.d0

    case ("Mars")
      !Mars: orbital period 1.8808158 Earth years
      age_in_years = seconds/31557600.d0/1.8808158d0

    case ("Jupiter")
      !Jupiter: orbital period 11.862615 Earth years
      age_in_years = seconds/31557600.d0/11.862615d0

    case ("Saturn")
      !Saturn: orbital period 29.447498 Earth years
      age_in_years = seconds/31557600.d0/29.447498d0

    case ("Uranus")
      !Uranus: orbital period 84.016846 Earth years
      age_in_years = seconds/31557600.d0/84.016846d0

    case ("Neptune")
      !Neptune: orbital period 164.79132 Earth years
      age_in_years = seconds/31557600.d0/164.79132d0

    case default
      write(*,*) 'ERROR: unknown planet: '//trim(planet)
    end select 

  end function

end module
