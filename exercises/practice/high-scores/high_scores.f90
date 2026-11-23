module high_scores
  implicit none

contains

  function scores(score_list)
    integer, dimension(:), intent(in) :: score_list
    integer, dimension(size(score_list)) :: scores

    scores = size(score_list) ! Replace this line with your implementation
  end function

  integer function latest(score_list)
    integer, dimension(:), intent(in) :: score_list

    latest = size(score_list) ! Replace this line with your implementation
  end function

  integer function personalBest(score_list)
    integer, dimension(:), intent(in) :: score_list

    personalBest = size(score_list) ! Replace this line with your implementation
  end function

  function personalTopThree(score_list)
    integer, dimension(:), intent(in) :: score_list
    integer, dimension(3) :: personalTopThree

    personalTopThree = size(score_list) ! Replace this line with your implementation
  end function

end module
