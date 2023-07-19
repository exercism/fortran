module two_fer
  implicit none

contains

  function twoFer(name) result(phrase)
    character(*), intent(in), optional :: name
    character(:), allocatable :: phrase
    character(:), allocatable :: newname

    if (present(name)) then
      allocate(character(len(name)) :: newname)
      newname = name
    else
      allocate(character(3) :: newname)
      newname = "you"
    end if

    phrase = "One for " // newname // ", one for me."
  end function twoFer

end module two_fer
