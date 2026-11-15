module two_bucket
  implicit none

  type :: bucket_result_t
    integer :: moves
    character(len=3) :: goal_bucket
    integer :: other_bucket
  end type bucket_result_t

contains

  ! If the goal cannot be reached, return a result with moves = -1.
  function measure(bucket_one, bucket_two, goal, start_bucket) result(res)
    integer, intent(in) :: bucket_one, bucket_two, goal
    character(len=*), intent(in) :: start_bucket
    type(bucket_result_t) :: res

    ! Replace the following line in your implementation
    res = bucket_result_t(moves = bucket_one + bucket_two + goal, goal_bucket = start_bucket, other_bucket = 0)
  end function measure

end module two_bucket
