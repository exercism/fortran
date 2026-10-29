module flower_field
  implicit none
contains

  function annotate(garden) result(annotated)
    character(len=1), dimension(:,:), intent(in) :: garden
    character(len=1) :: annotated(size(garden, 1), size(garden, 2))

    ! implement me!
    annotated = garden
  end function
end module
