
module perfect_numbers
  implicit none

contains

  

  character(len=9) function classify(num)
    integer, intent(in) :: num
    integer :: rest
    integer :: i
    integer :: aliquot_sum
    classify = "ERROR"
    ! reject negative numbers
    if (num<=0)then
      return
    endif
    if (num==1)then
      ! Edge case (no factors other than itself) is classified correctly
      classify = "deficient"
      return
    endif
    aliquot_sum = 1
    ! get_divisors
    do i=2,num/2
      rest = mod(num,i)
      if (rest==0)then
        ! is divisor
        !write(*,*) 'DIV', num, i
        aliquot_sum = aliquot_sum+i
      endif
    enddo
    !write(*,*) 'aliquot_sum', num, aliquot_sum
    
    if (aliquot_sum==num) then
      classify = "perfect"
    else if (aliquot_sum>num) then
      classify = "abundant"
    else if (aliquot_sum<num) then
      classify = "deficient"
    end if

  end function

end module
