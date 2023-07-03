module pangram
implicit none
contains
  logical function is_pangram(sentence)
    implicit none
    character(*) :: sentence
    logical :: seen(26)
    integer :: i,val

    seen = .false.

    do i = 1,len(sentence)
      val = to_index(sentence(i:i))
      if ( val .ne. 0 ) then
        seen(val:val) = .true.
      end if
    end do

    is_pangram = all(seen)
   end function is_pangram

   integer function to_index(chr)
       implicit none
       character :: chr

       if ((chr .ge. 'a' ) .and. (chr .le. 'z')) then
         to_index = ichar('z') - ichar(chr) + 1
       else if ((chr .ge. 'A' ) .and. (chr .le. 'Z')) then
         to_index = ichar('Z') - ichar(chr) + 1
       else
         to_index = 0
       end if
   end function to_index
end module pangram
