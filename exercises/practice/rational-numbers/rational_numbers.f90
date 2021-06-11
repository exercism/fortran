
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

  function rational_abs(r1)
    integer,dimension(2) :: rational_abs, r1
    ! Your code here    
  end function

  function rational_to_pow(r1, ex)
    integer,dimension(2) :: rational_to_pow, r1
    integer :: ex
    ! Your code here
  end function

  function real_to_rational_pow(ex,r1)
    integer,dimension(2) ::  r1
    real :: real_to_rational_pow,ex
    ! Your code here
  end function

  function reduce(r1)
    integer,dimension(2) :: reduce, r1
    ! Your code here
  end function

end module
