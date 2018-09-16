

module hello_world
  implicit none
  save
  private 
  public hello
  
contains

function hello()
  character(len=100) :: hello
  hello="Hello, World!"
  write(*,*) hello
end function

end module 
