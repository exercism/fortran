module two_bucket
  implicit none

  type :: bucket_result_t
    integer :: moves
    character(len=3) :: goal_bucket
    integer :: other_bucket
  end type bucket_result_t

contains

  ! Breadth-first search over states (level of bucket one, level of bucket two).
  ! Returns moves = -1 if the goal cannot be reached.
  function measure(bucket_one, bucket_two, goal, start_bucket) result(res)
    integer, intent(in) :: bucket_one, bucket_two, goal
    character(len=*), intent(in) :: start_bucket
    type(bucket_result_t) :: res

    integer :: dist(0:bucket_one, 0:bucket_two)
    integer :: queue(2, (bucket_one + 1) * (bucket_two + 1))
    integer :: head, tail, a, b, pour, k
    integer :: next(2, 6)
    logical :: start_one

    res = bucket_result_t(moves = -1, goal_bucket = "", other_bucket = 0)
    if (goal > max(bucket_one, bucket_two)) return

    start_one = start_bucket == "one"
    dist = -1
    head = 1
    tail = 1
    if (start_one) then
      queue(:, 1) = [bucket_one, 0]
    else
      queue(:, 1) = [0, bucket_two]
    end if
    dist(queue(1, 1), queue(2, 1)) = 1

    do while (head <= tail)
      a = queue(1, head)
      b = queue(2, head)
      head = head + 1

      if (a == goal) then
        res = bucket_result_t(moves = dist(a, b), goal_bucket = "one", other_bucket = b)
        return
      else if (b == goal) then
        res = bucket_result_t(moves = dist(a, b), goal_bucket = "two", other_bucket = a)
        return
      end if

      next(:, 1) = [bucket_one, b]        ! fill one
      next(:, 2) = [a, bucket_two]        ! fill two
      next(:, 3) = [0, b]                 ! empty one
      next(:, 4) = [a, 0]                 ! empty two
      pour = min(a, bucket_two - b)
      next(:, 5) = [a - pour, b + pour]   ! pour one into two
      pour = min(b, bucket_one - a)
      next(:, 6) = [a + pour, b - pour]   ! pour two into one

      do k = 1, 6
        associate (na => next(1, k), nb => next(2, k))
          if (dist(na, nb) /= -1) cycle
          ! Forbidden: starting bucket empty while the other is full
          if (start_one .and. na == 0 .and. nb == bucket_two) cycle
          if (.not. start_one .and. nb == 0 .and. na == bucket_one) cycle
          dist(na, nb) = dist(a, b) + 1
          tail = tail + 1
          queue(:, tail) = [na, nb]
        end associate
      end do
    end do
  end function measure

end module two_bucket
