
module collatz_conjecture
  implicit none
contains

  integer function steps(i)
    integer :: i
    integer :: j 
    if (i<1) then
      steps=-1
      return
    endif
    steps=0
    j = i
    do while (j>1)
      steps=steps+1
      if (mod(j,2)==0) then ! is even
        j=j/2
      else
        j=3*j+1
      endif
    end do

  end function

end module

