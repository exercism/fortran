module bob
  implicit none
contains

  function hey(statement)
    character(100) :: hey
    character(len=*), intent(in) :: statement

  end function hey

end module bob
