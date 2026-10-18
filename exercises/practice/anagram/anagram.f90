module anagram
  implicit none
contains

  function findAnagrams(subject, candidates) result(matches)
    character(len=*), intent(in) :: subject
    character(len=*), dimension(:), intent(in) :: candidates
    character(len=len(candidates)), allocatable :: matches(:)

    ! implement me!
    allocate(matches(0))
  end function
end module
