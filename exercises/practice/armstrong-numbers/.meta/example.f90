
module armstrong_numbers
  implicit none
contains

  logical function isArmstrongNumber(i)
    integer, intent(in) :: i
    integer :: slen, idx, j, sum
    character(len=100) :: s 

    isArmstrongNumber = .false.
    sum = 0
    write(s,'(i100)') i
    s=adjustl(s)
    slen = len_trim(s)
    do idx =1,slen
      read(s(idx:idx),*) j
      sum = sum + j**slen
    enddo
    if (sum == i) then
      isArmstrongNumber = .true.
    endif 
  end function

end module
