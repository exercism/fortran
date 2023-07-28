module linked_list
  use, intrinsic :: iso_fortran_env, only: error_unit
  implicit none

  type :: list_t
    private
    type(node_t), pointer :: first => null(), last => null()
    integer :: length = 0
  end type list_t

  type :: node_t
    private
    type(node_t), pointer :: next => null(), previous => null()
    integer :: val
  end type node_t

contains

  function new() result(list)
    type(list_t) :: list

  end function new

  subroutine push(list, val)
    type(list_t), intent(inout) :: list
    integer, intent(in) :: val
    type(node_t), pointer :: node
    integer :: status

    allocate(node, stat=status)
    if (status /= 0) then
      write(unit=error_unit, fmt='(A)') 'error: can not allocate node'
      stop 1
    end if

    node%val = val

    if (length(list) > 0) then
      node%previous => list%last
      list%last%next => node
    else
      list%first => node
    end if
    list%last => node
    list%length = list%length + 1
  end subroutine push

  function pop(list) result(val)
    type(list_t), intent(inout) :: list
    integer :: val
    type(node_t), pointer :: node

    if (length(list) == 0) then
      write(unit=error_unit, fmt='(A)') 'error: can not pop from empty list'
      stop 2
    end if

    node => list%last

    if (length(list) > 1) then
      list%last => node%previous
      nullify(node%previous)
    else
      nullify(list%first)
    end if

    val = node%val
    deallocate(node)
    list%length = list%length - 1
  end function pop

  subroutine unshift(list, val)
    type(list_t), intent(inout) :: list
    integer, intent(in) :: val
    type(node_t), pointer :: node
    integer :: status

    allocate(node, stat=status)
    if (status /= 0) then
      write(unit=error_unit, fmt='(A)') 'error: can not allocate node'
      stop 1
    end if

    node%val = val

    if (length(list) > 0) then
      node%next => list%first
      list%first%previous => node
    else
      list%last => node
    end if
    list%first => node
    list%length = list%length + 1
  end subroutine unshift

  function shift(list) result(val)
    type(list_t), intent(inout) :: list
    integer :: val
    type(node_t), pointer :: node

    if (length(list) == 0) then
      write(unit=error_unit, fmt='(A)') 'error: can not shift from empty list'
      stop 2
    end if

    node => list%first

    if (length(list) > 1) then
      list%first => node%next
      nullify(node%next)
    else
      nullify(list%last)
    end if

    val = node%val
    deallocate(node)
    list%length = list%length - 1
  end function shift

  function length(list) result(n)
    type(list_t), intent(in) :: list
    integer :: n

    n = list%length
  end function length

  subroutine delete(list, val)
    type(list_t), intent(inout) :: list
    integer :: val
    type(node_t), pointer :: node
    integer :: i, temp

    node => list%first

    do i = 1, length(list)
      if (node%val == val) exit
      node => node%next
    end do

    if (.not. associated(node)) return

    if (i == 1) then
      temp = shift(list)
      return
    end if

    if (i == length(list)) then
      temp = pop(list)
      return
    end if

    node%previous%next => node%next
    node%next%previous => node%previous
    deallocate(node)
    list%length = list%length - 1
  end subroutine delete

  subroutine destroy(list)
    type(list_t), intent(inout) :: list
    integer :: temp

    do while (length(list) > 0)
      temp = pop(list)
    end do
  end subroutine destroy

end module
