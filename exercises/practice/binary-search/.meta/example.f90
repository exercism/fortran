module binary_search
  implicit none
contains

  function find(array, val) result(idx)
    integer, dimension(:), intent(in) :: array
    integer, intent(in) :: val
    integer :: idx
    integer :: start_index, end_index, middle_index

    start_index = 1
    end_index = size(array)

    do while (end_index >= start_index)
      middle_index = (end_index + start_index) / 2

      if (array(middle_index) == val) then
        idx = middle_index
        return
      end if

      if (array(middle_index) > val) then
        end_index = middle_index - 1
      else if (array(middle_index) < val) then
        start_index = middle_index + 1
      end if
    end do

    idx = -1
  end function

end module
