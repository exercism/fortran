
module allergies
  implicit none

contains

  logical function allergicTo(allergy_str, allergy_key)
    character(len=*), intent(in) :: allergy_str
    integer, intent(in) :: allergy_key
    allergicTo = .false. 
  end function


  function allergicList(allergy_key)
    integer, intent(in) :: allergy_key
    character(len=100) :: allergicList
    allergicList = ' '
  end function



end module
