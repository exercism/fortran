module raindrops
implicit none
contains
  function convert(i)
    implicit none
    integer :: i
    character(20) :: convert

    convert = ''

    if ( mod(i,3) .eq. 0 ) then
      convert = 'Pling'
    end if
    if ( mod(i,5) .eq. 0 ) then
      convert = trim(convert)//'Plang'
    end if
    if ( mod(i,7) .eq. 0 ) then
      convert = trim(convert)//'Plong'
    end if

    if (convert .eq. '') then
      write( convert, '(i20)' ) i
      convert = trim(adjustl(convert))
    end if

  end function convert
end module raindrops
