
module matrix
  implicit none

contains

  function row(m, m_dim, i) result(r)
    integer, dimension(2), intent(in) :: m_dim
    !! Matrix dimensions (nrows, ncols)
    character(len=*), dimension(m_dim(1)), intent(in) :: m
    !! Matrix as a 1-d array of strings
    integer, intent(in) :: i
    !! Row index
    integer, dimension(m_dim(2)) :: r
    r(:) = 0
  end function

  function column(m, m_dim, j) result(c)
    integer, dimension(2), intent(in) :: m_dim
    !! Matrix dimensions (nrows, ncols)
    character(len=*), dimension(m_dim(1)), intent(in) :: m
    !! Matrix as a 1-d array of strings
    integer, intent(in) :: j
    !! Column index
    integer, dimension(m_dim(1)) :: c
    c(:) = 0
  end function

end module
