
! This test was isValidd from ..\problem-specifications\exercises\queen-attack\canonical-data.json
!

program queen_attack_test_main
  use TesterMain
  use queen_attack
  implicit none

  ! Test 1: queen with a valid position
  call assert_equal(.true., isValid([2, 2]), "queen with a valid position")
  ! Test 2: queen must have positive row
  ! ERROR: row not positive
  call assert_equal(.false., isValid([-2, 2]), "queen must have positive row")
  ! Test 3: queen must have row on board
  ! ERROR: row not on board
  call assert_equal(.false., isValid([9, 4]), "queen must have row on board")
  ! Test 4: queen must have positive column
  ! ERROR: column not positive
  call assert_equal(.false., isValid([2, -2]), "queen must have positive column")
  ! Test 5: queen must have column on board
  ! ERROR: column not on board
  call assert_equal(.false., isValid([4, 9]), "queen must have column on board")
  ! Test 6: cannot attack
  call assert_equal(.false., canAttack([2, 4], [6, 6]), "cannot attack")
  ! Test 7: can attack on same row
  call assert_equal(.true., canAttack([2, 4], [2, 6]), "can attack on same row")
  ! Test 8: can attack on same column
  call assert_equal(.true., canAttack([4, 5], [2, 5]), "can attack on same column")
  ! Test 9: can attack on first diagonal
  call assert_equal(.true., canAttack([3, 3], [1, 5]), "can attack on first diagonal")
  ! Test 10: can attack on second diagonal
  call assert_equal(.true., canAttack([2, 2], [3, 1]), "can attack on second diagonal")
  ! Test 11: can attack on third diagonal
  call assert_equal(.true., canAttack([2, 2], [1, 1]), "can attack on third diagonal")
  ! Test 12: can attack on fourth diagonal
  call assert_equal(.true., canAttack([2, 8], [1, 7]), "can attack on fourth diagonal")

  call test_report()

end program

