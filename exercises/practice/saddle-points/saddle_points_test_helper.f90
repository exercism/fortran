module saddle_points_test_helper
  use TesterMain
  use saddle_points, only: point_t
  implicit none
  private
  public :: assert_equal

  interface operator (==)
    module procedure eq_pnt
  end interface operator (==)

  interface assert_equal
    module procedure assert_equal_pnt_arr
  end interface assert_equal

contains

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

end module saddle_points_test_helper
