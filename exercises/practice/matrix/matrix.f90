
module matrix
  implicit none

contains

  function row(m, m_dim, i) result(r)
    character(len=*) :: m
    integer, intent(in) :: m_dim(2)
    integer, intent(in) :: i
    integer,dimension(m_dim(2)) :: r
    integer :: A(m_dim(1),m_dim(2))
    r(:) = 0
  end function

  function column(m, m_dim, j) result(c)
    character(len=*) :: m
    integer, intent(in) :: m_dim(2)
    integer, intent(in) :: j
    integer, dimension(m_dim(1)) :: c
    integer :: A(m_dim(1),m_dim(2))
    c(:) = 0
  end function

end module
