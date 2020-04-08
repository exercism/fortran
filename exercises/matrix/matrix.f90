
module matrix
  implicit none

contains

  function row(m, m_dim, i) result(r)
    character(len=*), dimension(:) :: m
    integer, intent(in) :: m_dim(2)
    integer, intent(in) :: i
    integer,dimension(m_dim(2)) :: r
    r(:) = 0
  end function

  function column(m, m_dim, j) result(c)
    character(len=*), dimension(:) :: m
    integer, intent(in) :: m_dim(2)
    integer, intent(in) :: j
    integer, dimension(m_dim(1)) :: c
    c(:) = 0
  end function
  
end module
