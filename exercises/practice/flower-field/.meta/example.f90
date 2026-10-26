module flower_field
  implicit none
  private
  public :: annotate
contains

  function annotate(garden) result(annotated)
    character(len=1), dimension(:,:), intent(in) :: garden
    character(len=1) :: annotated(size(garden, 1), size(garden, 2))
    integer :: nrows, ncols, r, c, n

    nrows = size(garden, 1)
    ncols = size(garden, 2)
    do c = 1, ncols
      do r = 1, nrows
        if (garden(r, c) == '*') then
          annotated(r, c) = '*'
          cycle
        end if
        ! count flowers in the (edge-clipped) 3x3 neighbourhood
        n = count(garden(max(1, r-1):min(nrows, r+1), max(1, c-1):min(ncols, c+1)) == '*')
        if (n == 0) then
          annotated(r, c) = ' '
        else
          annotated(r, c) = achar(iachar('0') + n)
        end if
      end do
    end do
  end function
end module
