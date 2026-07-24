module secret_handshake
  implicit none
contains

  function commands(number)
    integer, intent(in) :: number
    character(len=20), allocatable :: commands(:)
    character(len=20), dimension(4) :: todo
    integer :: count, mask, i
    character(len=20), dimension(4), parameter :: &
              cmd = [character(len=20) :: 'wink', 'double blink', 'close your eyes', 'jump']

    count = 0
    mask = 1
    do i = 1,4
      if (iand(number, mask) > 0) then
        count = count + 1
        todo(count) = cmd(i)
      end if
      mask = shiftl(mask, 1)
    end do

    allocate(commands(count))
    if (iand(number, mask) > 0) then
      commands = todo(count:1:-1)
    else
      commands = todo(1:count)
    end if
  end function

end module
