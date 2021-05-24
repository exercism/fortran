
module acronym
  implicit none
contains

  logical pure function is_lower_alfa(c)
    character, intent(in) :: c
    is_lower_alfa=.false.
    if ( c .ge. 'a' .and. c .le. 'z') then
      is_lower_alfa=.true.
    endif
  end function

  logical pure function is_upper_alfa(c)
    character, intent(in) :: c
    is_upper_alfa=.false.
    if ( c .ge. 'A' .and. c .le. 'Z') then
      is_upper_alfa=.true.
    endif
  end function

  logical pure function is_alfa(c)
    character, intent(in) :: c
    is_alfa = is_lower_alfa(c) .or. is_upper_alfa(c)
  end function

  character pure function to_upper(c)
    character, intent(in) :: c
    integer, parameter :: K=ichar('A') - ichar('a')
    to_upper=c
    if (.not. is_upper_alfa(c)) then
      to_upper=char(ichar(c)+K)
    endif
  end function


  function abbreviate(s)
    character(len=*), intent(in) :: s
    character(len=len_trim(s)) :: abbreviate
    integer :: i
    integer :: j
    integer :: k
    abbreviate=to_upper(s(1:1))
    j=0
    k=0
    do i=1,len_trim(s)
      if (is_alfa(s(i:i))) then
        j=j+1
        if (j==1) then
          k=k+1
          abbreviate(k:k)=to_upper(s(i:i))
        end if
      else if (s(i:i)=="'") then
        ! do nothing for appostrophe '
        continue
      else
        j=0
      end if
    end do
  end function

end module
