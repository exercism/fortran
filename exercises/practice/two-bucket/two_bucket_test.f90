! These tests are auto-generated with test data from:
! https://github.com/exercism/problem-specifications/blob/main/exercises/two-bucket/canonical-data.json
! File last updated on 2026-11-14T23:21:50+00:00

program two_bucket_test_main
  use TesterMain
  use two_bucket

  implicit none

  interface assert_equal
    procedure assert_equal_bucket_result
  end interface assert_equal

  ! Test 1: Measure using bucket one of size 3 and bucket two of size 5 - start with bucket one
  call assert_equal( &
    bucket_result_t(moves = 4, goal_bucket = "one", other_bucket = 5), &
    measure(3, 5, 1, "one"), &
    "Measure using bucket one of size 3 and bucket two of size 5 - start with bucket one")

  ! Test 2: Measure using bucket one of size 3 and bucket two of size 5 - start with bucket two
  call assert_equal( &
    bucket_result_t(moves = 8, goal_bucket = "two", other_bucket = 3), &
    measure(3, 5, 1, "two"), &
    "Measure using bucket one of size 3 and bucket two of size 5 - start with bucket two")

  ! Test 3: Measure using bucket one of size 7 and bucket two of size 11 - start with bucket one
  call assert_equal( &
    bucket_result_t(moves = 14, goal_bucket = "one", other_bucket = 11), &
    measure(7, 11, 2, "one"), &
    "Measure using bucket one of size 7 and bucket two of size 11 - start with bucket one")

  ! Test 4: Measure using bucket one of size 7 and bucket two of size 11 - start with bucket two
  call assert_equal( &
    bucket_result_t(moves = 18, goal_bucket = "two", other_bucket = 7), &
    measure(7, 11, 2, "two"), &
    "Measure using bucket one of size 7 and bucket two of size 11 - start with bucket two")

  ! Test 5: Measure one step using bucket one of size 1 and bucket two of size 3 - start with bucket two
  call assert_equal( &
    bucket_result_t(moves = 1, goal_bucket = "two", other_bucket = 0), &
    measure(1, 3, 3, "two"), &
    "Measure one step using bucket one of size 1 and bucket two of size 3 - start with bucket two")

  ! Test 6: Measure using bucket one of size 2 and bucket two of size 3 - start with bucket one and end with bucket two
  call assert_equal( &
    bucket_result_t(moves = 2, goal_bucket = "two", other_bucket = 2), &
    measure(2, 3, 3, "one"), &
    "Measure using bucket one of size 2 and bucket two of size 3 - start with bucket one and end with bucket two")

  ! Test 7: Measure using bucket one much bigger than bucket two
  call assert_equal( &
    bucket_result_t(moves = 6, goal_bucket = "one", other_bucket = 1), &
    measure(5, 1, 2, "one"), &
    "Measure using bucket one much bigger than bucket two")

  ! Test 8: Measure using bucket one much smaller than bucket two
  call assert_equal( &
    bucket_result_t(moves = 6, goal_bucket = "two", other_bucket = 0), &
    measure(3, 15, 9, "one"), &
    "Measure using bucket one much smaller than bucket two")

  ! Test 9: Not possible to reach the goal
  call assert_equal( &
    bucket_result_t(moves = -1, goal_bucket = "", other_bucket = 0), &
    measure(6, 15, 5, "one"), &
    "Not possible to reach the goal")

  ! Test 10: With the same buckets but a different goal, then it is possible
  call assert_equal( &
    bucket_result_t(moves = 10, goal_bucket = "two", other_bucket = 0), &
    measure(6, 15, 9, "one"), &
    "With the same buckets but a different goal, then it is possible")

  ! Test 11: Goal larger than both buckets is impossible
  call assert_equal( &
    bucket_result_t(moves = -1, goal_bucket = "", other_bucket = 0), &
    measure(5, 7, 8, "one"), &
    "Goal larger than both buckets is impossible")

  call test_report()

contains

  ! The following are used by the test runner to compare results. You don't
  ! need to use or understand these procedures to complete the exercise.

  ! An impossible goal is signalled by moves = -1; the other fields are then ignored.
  function eq_bucket_result(r1, r2) result(eq)
    type(bucket_result_t), intent(in) :: r1, r2
    logical :: eq

    if (r1%moves == -1 .or. r2%moves == -1) then
      eq = r1%moves == r2%moves
    else
      eq = r1%moves == r2%moves .and. &
           r1%goal_bucket == r2%goal_bucket .and. &
           r1%other_bucket == r2%other_bucket
    end if
  end function eq_bucket_result

  subroutine assert_equal_bucket_result(e_res, i_res, test_description)
    type(bucket_result_t), intent(in) :: e_res, i_res
    character(*), intent(in) :: test_description
    character(MAX_STRING_LEN) :: expected_msg

    TESTS_RUN = TESTS_RUN + 1

    if (.not. eq_bucket_result(e_res, i_res)) then
      call test_fail_msg(test_description)
      expected_msg = get_expected_msg(br_to_s(e_res), br_to_s(i_res))
      call elogger(expected_msg)
      call write_json_fail(test_description, expected_msg)
    else
      call write_json_success(test_description)
    end if
  end subroutine assert_equal_bucket_result

  function br_to_s(r) result(s)
    type(bucket_result_t), intent(in) :: r
    character(MAX_RESULT_STRING_LEN) :: s

    if (r%moves == -1) then
      s = "impossible (moves = -1)"
    else
      write(s, '("(", i0, ", ", a, ", ", i0, ")")') r%moves, trim(r%goal_bucket), r%other_bucket
    end if
  end function br_to_s

end program two_bucket_test_main
