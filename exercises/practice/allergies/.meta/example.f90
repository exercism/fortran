
module allergies
  implicit none

  integer,parameter :: ALLERGY_TYPES_LEN=8

  integer, parameter :: unknown =0
  integer, parameter :: eggs =1
  integer, parameter :: peanuts =2
  integer, parameter :: shellfish =3
  integer, parameter :: strawberries =4
  integer, parameter :: tomatoes =5
  integer, parameter :: chocolate =6
  integer, parameter :: pollen =7
  integer, parameter :: cats =8

  integer, parameter, dimension(ALLERGY_TYPES_LEN) :: ALLERGY_TYPES_BITS = (/ &
    & 1, 2, 4, 8, 16, 32, 64, 128 /)

  character(len=12), dimension(ALLERGY_TYPES_LEN), parameter :: ALLERGY_TYPES_STR = (/ &
    &  "eggs        ", &
    &  "peanuts     ", &
    &  "shellfish   ", &
    &  "strawberries", &
    &  "tomatoes    ", &
    &  "chocolate   ", &
    &  "pollen      ", &
    &  "cats        " /)

contains

  logical function allergicTo(allergy_str, allergy_key)
    character(len=*), intent(in) :: allergy_str
    integer, intent(in) :: allergy_key
    integer allergy_idx

    allergy_idx = get_allergy_idx_from_str(allergy_str)
    allergicTo = btest(allergy_key,allergy_idx-1 )    
    !write(*,*) allergy_str, allergy_idx, allergicTo, ibits(allergy_bit, 1,8)

  end function


  function allergicList(allergy_key)
    integer, intent(in) :: allergy_key
    character(len=100) :: allergicList
    integer i
    allergicList = ' '
    do i=1,ALLERGY_TYPES_LEN
      if ( btest(allergy_key,i-1 ) ) then
        allergicList = trim(allergicList)//' '//trim(ALLERGY_TYPES_STR(i))
      end if
    end do
    allergicList = adjustl(allergicList)
    !write(*,*) allergicList
  end function


  integer function get_allergy_idx_from_str(allergy_str)
    character(len=*), intent(in) :: allergy_str
    integer :: i
    get_allergy_idx_from_str = unknown

    do i=1,ALLERGY_TYPES_LEN
      if ( trim(allergy_str) == trim(ALLERGY_TYPES_STR(i) ))  then
        get_allergy_idx_from_str = i
      end if
    end do
    if (get_allergy_idx_from_str == unknown) then 
      write(*,*) 'ERROR: Wrong allergy type'
    end if
  end function



end module
