module linked_list
  implicit none

  type :: list_t
    integer :: placeholder ! Replace this line in your implementation
  end type list_t

contains

  function new() result(list)
    type(list_t) :: list

    list%placeholder = -1 ! Replace this line in your implementation
  end function new

  subroutine push(list, val)
    type(list_t), intent(inout) :: list
    integer, intent(in) :: val

    list%placeholder = list%placeholder + val ! Replace this line in your implementation
  end subroutine push

  function pop(list) result(val)
    type(list_t), intent(inout) :: list
    integer :: val

    val = list%placeholder ! Replace this line in your implementation
  end function pop

  subroutine unshift(list, val)
    type(list_t), intent(inout) :: list
    integer, intent(in) :: val

    list%placeholder = list%placeholder + val ! Replace this line in your implementation
  end subroutine unshift

  function shift(list) result(val)
    type(list_t), intent(inout) :: list
    integer :: val

    val = list%placeholder ! Replace this line in your implementation
  end function shift

  function length(list) result(n)
    type(list_t), intent(in) :: list
    integer :: n

    n = list%placeholder ! Replace this line in your implementation
  end function length

  subroutine delete(list, val)
    type(list_t), intent(inout) :: list
    integer :: val

    list%placeholder = list%placeholder + val ! Replace this line in your implementation
  end subroutine delete

  subroutine destroy(list)
    type(list_t), intent(inout) :: list

    list = list ! Replace this line in your implementation
  end subroutine destroy

end module
