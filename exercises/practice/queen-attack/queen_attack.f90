
module queen_attack
  implicit none
contains

  logical function isValid(pos)
    integer, dimension(2) :: pos
    isValid = .false.
  end function

  logical function canAttack(white_pos, black_pos)
    integer, dimension(2) :: white_pos, black_pos
    canAttack = .false.
  end function

end module
