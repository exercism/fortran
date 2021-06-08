
module rational_numbers
  implicit none
contains

  function add(r1,r2)
    integer,dimension(2) :: add, r1,r2
    ! Your code here
  end function

  function sub(r1,r2)
    integer,dimension(2) :: sub, r1,r2
    ! Your code here
  end function

  function mul(r1,r2)
    integer,dimension(2) :: mul, r1,r2
    ! Your code here
  end function

  function div(r1,r2)
    integer,dimension(2) :: div, r1,r2
    ! Your code here
  end function

  function rabs(r1)
    integer,dimension(2) :: rabs, r1
    ! Your code here    
  end function

  function exprational(r1, ex)
    integer,dimension(2) :: exprational, r1
    integer :: ex
    ! Your code here
  end function

  function expreal(ex,r1)
    integer,dimension(2) ::  r1
    real :: expreal,ex
    ! Your code here
  end function

  function reduce(r1)
    integer,dimension(2) :: reduce, r1
    ! Your code here
  end function

end module
