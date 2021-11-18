
module matrix
  implicit none

contains

  function row(m, m_dim, i) result(r)
    integer, intent(in) :: m_dim(2)
    character(len=*), dimension(m_dim(1)), intent(in) :: m
    integer, intent(in) :: i
    integer, dimension(m_dim(2)) :: r
    r(:) = 0
  end function

  function column(m, m_dim, j) result(c)
    integer, intent(in) :: m_dim(2)
    character(len=*), dimension(m_dim(1)), intent(in) :: m
    integer, intent(in) :: j
    integer, dimension(m_dim(1)) :: c
    c(:) = 0
  end function

end module
