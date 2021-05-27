module nth_prime
  implicit none
contains

  ! loop from 2 to n/2. If mod(i,n)==0 this is not prime
  logical pure function is_prime(n)

    integer, intent(in) :: n
    integer :: i

    is_prime=.true.
    do i=2,n/2
      if ( mod(n,i)==0 ) then
        is_prime = .false.
        return
      end if
    end do
  end function

  ! get nth prime
  integer pure function prime(n)
    integer, intent(in) :: n
    integer :: i,j 
    prime = -1
    if (n<1) then
      return
    endif
    j=0
    i=1
    do while (j<n )
      i=i+1
      !write(*,*)  'Prime',i,j
      if (is_prime(i)) then
        j=j+1
      endif
    end do
    prime=i
  end function

end module
