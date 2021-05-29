
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
  real, parameter :: TOL = 1.0E-8

  contains

  logical function intol(a,b)
    real :: a,b
    intol = abs(a-b)<TOL
  end function

  logical function istrianle_real(tria)
    ! sum of 2 sides > other side
    real,dimension(3) :: tria
    istrianle_real = sum(tria(1:2))>tria(3) .and. sum(tria(2:3))>tria(1) .and. tria(1)+tria(3)>tria(2)
  end function
  logical function istrianle_int(tria)
    ! sum of 2 sides > other side
    integer,dimension(3) :: tria
    istrianle_int = sum(tria(1:2))>tria(3) .and. sum(tria(2:3))>tria(1) .and. tria(1)+tria(3)>tria(2)
  end function

  logical function equilateral_real(tria)
    real,dimension(3) :: tria
    equilateral_real= istrianle_real(tria) .and. intol(tria(1),tria(2)) .and.intol(tria(1),tria(3)) .and. .not. intol(tria(1),0.0)
  end function

  logical function equilateral_int(tria)
    integer,dimension(3) :: tria
    equilateral_int=istrianle_int(tria) .and. tria(1)==tria(2) .and.tria(1)==tria(3) .and. tria(1)/=0
  end function

  logical function isosceles_real(tria)
    real,dimension(3) :: tria
    isosceles_real=.false.
    if (equilateral_real(tria))then
      isosceles_real = .true.
      return
    endif
    isosceles_real = istrianle_real(tria) .and. intol(tria(1),tria(2)) .or. intol(tria(1),tria(3)) .or. intol(tria(2),tria(3))
  end function

  logical function isosceles_int(tria)
    integer,dimension(3) :: tria
    isosceles_int=.false.
    if (equilateral_int(tria))then
      isosceles_int = .true.
      return
    endif
    isosceles_int =istrianle_int(tria) .and. (tria(1)==tria(2) .or. tria(1)==tria(3) .or. tria(2)==tria(3))
  end function


  logical function scalene_real(tria)
    real,dimension(3) :: tria
    scalene_real = istrianle_real(tria) .and. .not. isosceles(tria) .and. .not. equilateral(tria)
  end function

  logical function scalene_int(tria)
    integer,dimension(3) :: tria
    scalene_int = istrianle_int(tria) .and. .not. isosceles(tria) .and. .not. equilateral(tria)
  end function


end module
