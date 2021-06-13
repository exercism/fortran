
module triangle
  implicit none

  interface equilateral
    module procedure equilateral_real
    module procedure equilateral_int
  end interface

  interface scalene
    module procedure scalene_real
    module procedure scalene_int
  end interface

  interface isosceles
    module procedure isosceles_real
    module procedure isosceles_int
  end interface

 contains

  logical function equilateral_real(edges)
    real,dimension(3) :: edges
    equilateral_real = .false.
  end function

  logical function equilateral_int(edges)
    integer,dimension(3) :: edges
    equilateral_int = .false.
  end function

  logical function isosceles_real(edges)
    real,dimension(3) :: edges
    isosceles_real = .false.
  end function

  logical function isosceles_int(edges)
    integer,dimension(3) :: edges
    isosceles_int = .false.
  end function


  logical function scalene_real(edges)
    real,dimension(3) :: edges
    scalene_real = .false.
  end function

  logical function scalene_int(edges)
    integer,dimension(3) :: edges
    scalene_int = .false.
  end function

end module
