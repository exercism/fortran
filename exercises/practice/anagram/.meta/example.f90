module anagram
  implicit none
  private
  public :: findAnagrams
contains

  function findAnagrams(subject, candidates) result(matches)
    character(len=*), intent(in) :: subject
    character(len=*), dimension(:), intent(in) :: candidates
    character(len=len(candidates)), allocatable :: matches(:)
    integer, allocatable :: subject_cps(:), word_cps(:)
    logical :: keep(size(candidates))
    integer :: i

    subject_cps = lower_codepoints(subject)
    do i = 1, size(candidates)
      word_cps = lower_codepoints(candidates(i))
      keep(i) = .false.
      if (size(word_cps) /= size(subject_cps)) cycle
      ! a word is not an anagram of itself
      if (all(word_cps == subject_cps)) cycle
      keep(i) = all(sorted(word_cps) == sorted(subject_cps))
    end do
    matches = pack(candidates, keep)
  end function

  ! Decode UTF-8 bytes into lowercased Unicode code points
  function lower_codepoints(str) result(cps)
    character(len=*), intent(in) :: str
    integer, allocatable :: cps(:)
    integer :: buffer(len_trim(str))
    integer :: i, n, b, cp, extra

    n = 0
    i = 1
    do while (i <= len_trim(str))
      b = ichar(str(i:i))
      if (b >= 240) then
        cp = b - 240
        extra = 3
      else if (b >= 224) then
        cp = b - 224
        extra = 2
      else if (b >= 192) then
        cp = b - 192
        extra = 1
      else
        cp = b
        extra = 0
      end if
      do while (extra > 0 .and. i < len_trim(str))
        i = i + 1
        cp = cp * 64 + (ichar(str(i:i)) - 128)
        extra = extra - 1
      end do
      n = n + 1
      buffer(n) = to_lower(cp)
      i = i + 1
    end do
    cps = buffer(1:n)
  end function

  ! Lowercase ASCII and Greek capital letters
  pure integer function to_lower(cp)
    integer, intent(in) :: cp

    to_lower = cp
    if (cp >= 65 .and. cp <= 90) then
      to_lower = cp + 32
    else if (cp >= 913 .and. cp <= 937 .and. cp /= 930) then
      to_lower = cp + 32
    end if
  end function

  ! Insertion sort
  pure function sorted(arr) result(res)
    integer, intent(in) :: arr(:)
    integer :: res(size(arr))
    integer :: i, j, tmp

    res = arr
    do i = 2, size(res)
      tmp = res(i)
      j = i - 1
      do while (j >= 1)
        if (res(j) <= tmp) exit
        res(j + 1) = res(j)
        j = j - 1
      end do
      res(j + 1) = tmp
    end do
  end function
end module
