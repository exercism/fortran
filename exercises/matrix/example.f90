
module matrix
  implicit none

contains

  function row(m,i) result(r)
    integer, dimension(:,:) :: m
    integer, intent(in) :: i
    integer :: r(size(m,1))
    r(:) = m(:,i)
  end function

  function column(m,j) result(c)
    integer, dimension(:,:) :: m
    integer, intent(in) :: j
    integer, dimension(size(m,2)) :: c
    c(:) = m(j,:)
  end function

end module
