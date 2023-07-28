! The tests were created from https://github.com/exercism/problem-specifications/blob/main/exercises/saddle-points/canonical-data.json

program saddle_points_test_main
  use TesterMain
  use saddle_points
  implicit none

  interface operator (==)
    procedure eq_pnt
  end interface operator (==)

  interface assert_equal
    procedure assert_equal_pnt_arr
  end interface assert_equal

  ! Test 1: Can identify single saddle point
  call assert_equal( &
    [point_t(row = 2, column = 1)], &
    saddlePoints(reshape([9, 5, 6, 8, 3, 6, 7, 2, 7], [3, 3])), &
    "Can identify single saddle point")

  ! Test 2: Can identify that empty matrix has no saddle points
  call assert_equal( &
    [point_t::], &
    saddlePoints(reshape([integer::], [0, 0])), &
    "Can identify that empty matrix has no saddle points")

  ! Test 3: Can identify lack of saddle points when there are none
  call assert_equal( &
    [point_t::], &
    saddlePoints(reshape([1, 3, 2, 2, 1, 3, 3, 2, 1], [3, 3])), &
    "Can identify lack of saddle points when there are none")

  ! Test 4: Can identify multiple saddle points in a column
  call assert_equal( &
    [point_t(row = 1, column = 2), point_t(row = 2, column = 2), point_t(row = 3, column = 2)], &
    saddlePoints(reshape([4, 3, 1, 5, 5, 5, 4, 5, 4], [3, 3])), &
    "Can identify multiple saddle points in a column")

  ! Test 5: Can identify multiple saddle points in a row
  call assert_equal( &
    [point_t(row = 2, column = 1), point_t(row = 2, column = 2), point_t(row = 2, column = 3)], &
    saddlePoints(reshape([6, 5, 7, 7, 5, 5, 8, 5, 6], [3, 3])), &
    "Can identify multiple saddle points in a row")

  ! Test 6: Can identify saddle point in bottom right corner
  call assert_equal( &
    [point_t(row = 3, column = 3)], &
    saddlePoints(reshape([8, 6, 3, 7, 7, 2, 9, 6, 5], [3, 3])), &
    "Can identify saddle point in bottom right corner")

  ! Test 7: Can identify saddle points in a non square matrix
  call assert_equal( &
    [point_t(row = 1, column = 1), point_t(row = 1, column = 3)], &
    saddlePoints(reshape([3, 3, 1, 2, 3, 4], [2, 3])), &
    "Can identify saddle points in a non square matrix")

  ! Test 8: Can identify that saddle points in a single column matrix are those with the minimum value
  call assert_equal( &
    [point_t(row = 2, column = 1), point_t(row = 4, column = 1)], &
    saddlePoints(reshape([2, 1, 4, 1], [4, 1])), &
    "Can identify that saddle points in a single column matrix are those with the minimum value")

  ! Test 9: Can identify that saddle points in a single row matrix are those with the maximum value
  call assert_equal( &
    [point_t(row = 1, column = 2), point_t(row = 1, column = 4)], &
    saddlePoints(reshape([2, 5, 3, 5], [1, 4])), &
    "Can identify that saddle points in a single row matrix are those with the maximum value")

  call test_report()

contains

  ! The following are used by the test runner to compare arrays of points. You
  ! don't need to use or understand these procedures to complete the exercise.

  function eq_pnt(p1, p2) result(eq)
    type(point_t), intent(in) :: p1, p2
    logical :: eq

    eq = p1%row == p2%row .and. p1%column == p2%column
  end function eq_pnt

  subroutine assert_equal_pnt_arr(e_pnt_arr, i_pnt_arr, test_description)
    type(point_t), intent(in) :: e_pnt_arr(:), i_pnt_arr(:)
    character(*), intent(in) :: test_description
    logical :: assert_test
    character(MAX_STRING_LEN) :: expected_msg
    integer :: i

    TESTS_RUN = TESTS_RUN + 1

    assert_test = size(e_pnt_arr) == size(i_pnt_arr)

    if (.not. assert_test) then
      call test_fail_msg(test_description)
      call elogger('Arrays are not the same size!')
      expected_msg = get_expected_msg(adjustl(pa_to_s(e_pnt_arr)), adjustl(pa_to_s(i_pnt_arr)))
      call elogger(expected_msg)
      call write_json_fail(test_description, expected_msg)
      return
    end if

    do i = 1, size(e_pnt_arr)
      assert_test = i_pnt_arr(i) == e_pnt_arr(i)
      if (.not. assert_test) exit
    end do

    if (.not. assert_test) then
      call test_fail_msg(test_description)
      expected_msg = get_expected_msg(adjustl(pa_to_s(e_pnt_arr)), adjustl(pa_to_s(i_pnt_arr)))
      call elogger(expected_msg)
      call write_json_fail(test_description, expected_msg)
    else
      call write_json_success(test_description)
    end if
  end subroutine assert_equal_pnt_arr

  function pa_to_s(ps) result(ss)
    type(point_t), intent(in) :: ps(:)
    character(MAX_STRING_LEN) :: ss
    character(5) :: s
    integer :: i

    ss = ''
    do i = 1, size(ps)
      write(s, '(A, I1, A, I1, A)') '(', ps(i)%row, ',', ps(i)%column, ')'
      ss = trim(ss) // s
    end do
  end function pa_to_s

end program saddle_points_test_main
