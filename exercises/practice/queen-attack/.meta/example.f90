
module queen_attack
  implicit none
contains

  logical function isValid(pos)
    integer, dimension(2) :: pos
    ! check if valid
    isValid = all(pos(:) > 0) .and. all(pos(:) < 9)
  end function

  logical function canAttack(white_pos, black_pos)
    integer, dimension(2) :: white_pos, black_pos, dx
    canAttack = .false.
    if (isValid(white_pos) .and. isValid(black_pos)) then 
      dx = abs(white_pos(:) - black_pos(:))
      canAttack = dx(1)==0 & ! same row
        & .or. dx(2)==0 & ! same column
        & .or. dx(1)==dx(2) ! on diagonal
    endif 
  end function

end module
