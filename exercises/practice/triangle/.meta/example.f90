
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

  logical function is_triangle_real(edges)
    ! sum of 2 sides > other side
    real,dimension(3) :: edges
    is_triangle_real = sum(edges(1:2))>edges(3) .and. sum(edges(2:3))>edges(1) &
      &  .and. edges(1)+edges(3)>edges(2)
  end function
  logical function is_triangle_int(edges)
    ! sum of 2 sides > other side
    integer,dimension(3) :: edges
    is_triangle_int = sum(edges(1:2))>edges(3) .and. sum(edges(2:3))>edges(1) &
     & .and. edges(1)+edges(3)>edges(2)
  end function

  logical function equilateral_real(edges)
    real,dimension(3) :: edges
    equilateral_real= is_triangle_real(edges) .and. intol(edges(1),edges(2)) &
      & .and. intol(edges(1),edges(3)) .and. .not. intol(edges(1),0.0)
  end function

  logical function equilateral_int(edges)
    integer,dimension(3) :: edges
    equilateral_int=is_triangle_int(edges) .and. edges(1)==edges(2) &
      &  .and.edges(1)==edges(3) .and. edges(1)/=0
  end function

  logical function isosceles_real(edges)
    real,dimension(3) :: edges
    isosceles_real=.false.
    if (equilateral_real(edges))then
      isosceles_real = .true.
      return
    endif
    isosceles_real = is_triangle_real(edges) .and. intol(edges(1),edges(2))  &
      & .or. intol(edges(1),edges(3)) .or. intol(edges(2),edges(3))
  end function

  logical function isosceles_int(edges)
    integer,dimension(3) :: edges
    isosceles_int=.false.
    if (equilateral_int(edges))then
      isosceles_int = .true.
      return
    endif
    isosceles_int =is_triangle_int(edges) .and. (edges(1)==edges(2) &
      & .or. edges(1)==edges(3) .or. edges(2)==edges(3))
  end function


  logical function scalene_real(edges)
    real,dimension(3) :: edges
    scalene_real = is_triangle_real(edges) .and. .not. isosceles(edges) &
      &  .and. .not. equilateral(edges)
  end function

  logical function scalene_int(edges)
    integer,dimension(3) :: edges
    scalene_int = is_triangle_int(edges) .and. .not. isosceles(edges) &
      & .and. .not. equilateral(edges)
  end function


end module
