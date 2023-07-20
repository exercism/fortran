module two_fer
  implicit none

contains

  function twoFer(name) result(phrase)
    character(*), intent(in), optional :: name
    character(:), allocatable :: phrase

    phrase = name ! Replace this line with your implementation
  end function twoFer

end module two_fer
