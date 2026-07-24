module secret_handshake
  implicit none
contains

  function commands(number)
    integer, intent(in) :: number
    character(len=20), allocatable :: commands(:)

    commands = []  ! Replace this line with your implementation
  end function

end module
