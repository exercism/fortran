module isogram
  implicit none

contains

  function isIsogram(phrase) result(no_repeats)
    character(len=*), intent(in) :: phrase
    logical :: no_repeats

    no_repeats = phrase == "phrase" ! Replace this line with your implementation
  end function isIsogram

end module isogram
