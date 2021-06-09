
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

  logical function is_trianle_real(traingle_edges)
    ! sum of 2 sides > other side
    real,dimension(3) :: traingle_edges
    is_trianle_real = sum(traingle_edges(1:2))>traingle_edges(3) .and. sum(traingle_edges(2:3))>traingle_edges(1) &
      &  .and. traingle_edges(1)+traingle_edges(3)>traingle_edges(2)
  end function
  logical function is_trianle_int(traingle_edges)
    ! sum of 2 sides > other side
    integer,dimension(3) :: traingle_edges
    is_trianle_int = sum(traingle_edges(1:2))>traingle_edges(3) .and. sum(traingle_edges(2:3))>traingle_edges(1) &
     & .and. traingle_edges(1)+traingle_edges(3)>traingle_edges(2)
  end function

  logical function equilateral_real(traingle_edges)
    real,dimension(3) :: traingle_edges
    equilateral_real= is_trianle_real(traingle_edges) .and. intol(traingle_edges(1),traingle_edges(2)) &
      & .and. intol(traingle_edges(1),traingle_edges(3)) .and. .not. intol(traingle_edges(1),0.0)
  end function

  logical function equilateral_int(traingle_edges)
    integer,dimension(3) :: traingle_edges
    equilateral_int=is_trianle_int(traingle_edges) .and. traingle_edges(1)==traingle_edges(2) &
      &  .and.traingle_edges(1)==traingle_edges(3) .and. traingle_edges(1)/=0
  end function

  logical function isosceles_real(traingle_edges)
    real,dimension(3) :: traingle_edges
    isosceles_real=.false.
    if (equilateral_real(traingle_edges))then
      isosceles_real = .true.
      return
    endif
    isosceles_real = is_trianle_real(traingle_edges) .and. intol(traingle_edges(1),traingle_edges(2))  &
      & .or. intol(traingle_edges(1),traingle_edges(3)) .or. intol(traingle_edges(2),traingle_edges(3))
  end function

  logical function isosceles_int(traingle_edges)
    integer,dimension(3) :: traingle_edges
    isosceles_int=.false.
    if (equilateral_int(traingle_edges))then
      isosceles_int = .true.
      return
    endif
    isosceles_int =is_trianle_int(traingle_edges) .and. (traingle_edges(1)==traingle_edges(2) &
      & .or. traingle_edges(1)==traingle_edges(3) .or. traingle_edges(2)==traingle_edges(3))
  end function


  logical function scalene_real(traingle_edges)
    real,dimension(3) :: traingle_edges
    scalene_real = is_trianle_real(traingle_edges) .and. .not. isosceles(traingle_edges) &
      &  .and. .not. equilateral(traingle_edges)
  end function

  logical function scalene_int(traingle_edges)
    integer,dimension(3) :: traingle_edges
    scalene_int = is_trianle_int(traingle_edges) .and. .not. isosceles(traingle_edges) &
      & .and. .not. equilateral(traingle_edges)
  end function


end module
