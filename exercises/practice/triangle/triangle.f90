
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

  logical function equilateral_real(traingle_edges)
    real,dimension(3) :: traingle_edges
    equilateral_real = .false.
  end function

  logical function equilateral_int(traingle_edges)
    integer,dimension(3) :: traingle_edges
    equilateral_int = .false.
  end function

  logical function isosceles_real(traingle_edges)
    real,dimension(3) :: traingle_edges
    isosceles_real = .false.
  end function

  logical function isosceles_int(traingle_edges)
    integer,dimension(3) :: traingle_edges
    isosceles_int = .false.
  end function


  logical function scalene_real(traingle_edges)
    real,dimension(3) :: traingle_edges
    scalene_real = .false.
  end function

  logical function scalene_int(traingle_edges)
    integer,dimension(3) :: traingle_edges
    scalene_int = .false.
  end function

end module
