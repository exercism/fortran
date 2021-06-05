
module high_scores
  implicit none
contains

function scores(score_list)
  integer, dimension(:) :: score_list
  integer, dimension(:) :: scores(size(score_list))
  scores(:) = score_list(:)
end function

integer function latest(score_list)
  integer, dimension(:) :: score_list
  integer :: slen 
  slen = size(score_list)
  latest = score_list(slen)
end function


integer function personalBest(score_list)
  integer, dimension(:) :: score_list
  personalBest = maxval(score_list) 
end function


 function personalTopThree(score_list)
  integer, dimension(:) :: score_list
  logical, dimension(:) :: score_list_mask(size(score_list))
  integer, dimension(3) :: personalTopThree
  integer :: i
  integer :: j
  personalTopThree=[0,0,0]
  score_list_mask(:) = .true.
  do i=1,min(3, size(score_list))
    personalTopThree(i) = maxval(score_list, mask=score_list_mask) 
    j = maxloc(score_list, dim=1, mask=score_list_mask)
    score_list_mask(j) = .false.
  end do
end function


  
end module
