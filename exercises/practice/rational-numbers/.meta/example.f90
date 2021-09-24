
module rational_numbers
  implicit none
contains

  function add(r1,r2)
    integer,dimension(2) :: add, r1,r2
    !(a1 * b2 + a2 * b1) / (b1 * b2)
    add(1) = r1(1)*r2(2)+r2(1)*r1(2)
    add(2) = r1(2)*r2(2)
    add = reduce(add)
  end function

  function sub(r1,r2)
    integer,dimension(2) :: sub, r1,r2
    !r₁ - r₂ = a₁/b₁ - a₂/b₂ = (a₁ * b₂ - a₂ * b₁) / (b₁ * b₂).
    sub(1) = r1(1)*r2(2)-r2(1)*r1(2)
    sub(2) = r1(2)*r2(2)
    sub = reduce(sub)
  end function

  function mul(r1,r2)
    integer,dimension(2) :: mul, r1,r2
    !r₁ * r₂ = (a₁ * a₂) / (b₁ * b₂).
    mul(1) = r1(1)*r2(1)
    mul(2) = r1(2)*r2(2)
    mul = reduce(mul)
  end function

  function div(r1,r2)
    integer,dimension(2) :: div, r1,r2
    ! r₁ / r₂ = (a₁ * b₂) / (a₂ * b₁)
    div(1) = r1(1)*r2(2)
    div(2) = r1(2)*r2(1)
    div = reduce(div)
  end function

  function rational_abs(r1)
    integer,dimension(2) :: rational_abs, r1
    rational_abs(1) = abs(r1(1))
    rational_abs(2) = abs(r1(2))
  end function


  function rational_to_pow(r1, ex)
    integer,dimension(2) :: rational_to_pow, r1
    integer :: ex
    !(a1 * b2 + a2 * b1) / (b1 * b2)
    rational_to_pow(1) = r1(1)**ex
    rational_to_pow(2) = r1(2)**ex
  end function

  
  function real_to_rational_pow(ex,r1)
    integer,dimension(2) ::  r1
    real :: real_to_rational_pow,ex
    !(a1 * b2 + a2 * b1) / (b1 * b2)
    if ( r1(1)==0 ) then
      real_to_rational_pow=1.0
    else  
      real_to_rational_pow = ex**(real(r1(1))/real(r1(2)))
    endif
  end function


  function gcd(m,n)
    integer,intent(in)  :: m, n
    integer :: gcd,irest,ifirst
    ifirst=abs(m)
    gcd=abs(n)
    if(gcd==0)then
      gcd=ifirst
    else
      do
        irest = mod(ifirst,gcd)
        if(irest == 0)  exit
        ifirst = gcd
        gcd = irest
      enddo
      gcd= abs(gcd)
    endif
  end function

  function reduce(r1)
    integer,dimension(2) :: reduce, r1
    integer :: gcd_num 
    !(a1 * b2 + a2 * b1) / (b1 * b2)
    gcd_num = gcd(r1(1),r1(2))
    reduce(:) = r1(:)/gcd_num
    if (reduce(2)<0)then ! fix sign
      reduce = -reduce
    endif
  end function

end module
