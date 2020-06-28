
module matrix
  implicit none

contains

  function row(m, m_dim, i) result(r)
    character(len=*) :: m
    integer, intent(in) :: m_dim(2)
    integer, intent(in) :: i
    integer,dimension(m_dim(2)) :: r
    integer :: A(m_dim(1),m_dim(2))
    call read_m(m,m_dim, A)
    r(:) = A(:,i)
  end function

  function column(m, m_dim, j) result(c)
    character(len=*) :: m
    integer, intent(in) :: m_dim(2)
    integer, intent(in) :: j
    integer, dimension(m_dim(1)) :: c
    integer :: A(m_dim(1),m_dim(2))
    call read_m(m,m_dim, A)
    c(:) = A(j,:)
  end function

  subroutine read_m(m,m_dim, A)
    character(len=*) :: m
    integer, intent(in) :: m_dim(2)
    integer :: A(m_dim(1),m_dim(2))
    !integer :: ai(m_dim(1),m_dim(2))
    integer :: i
    integer, parameter :: funit=21
    open(funit, file=m)
    do i=1,m_dim(2)
      read(funit,*) A(:,i)
    enddo
    close(funit)
    !write(*,*) A

  end subroutine

end module
