module luhn
   implicit none
   private
   public :: validate

contains

   function validate(number) result(valid)
      character(*), intent(in) :: number
      logical :: valid
      integer :: ndigits, checksum, i, digit

      ndigits = 0
      checksum = 0

      do i = len_trim(number), 1, -1

         if ('0' <= number(i:i) .and. number(i:i) <= '9') then
            digit = ichar(number(i:i)) - ichar('0')
            call update(digit, ndigits, checksum)
         else if (number(i:i) /= ' ') then
            valid = .false.
            return
         end if

      end do

      valid = ndigits > 1 .and. mod(checksum, 10) == 0
   end function validate

   subroutine update(digit, ndigits, checksum)
      integer, intent(in) :: digit
      integer, intent(inout) :: ndigits, checksum

      ndigits = ndigits + 1

      if (mod(ndigits, 2) == 0) then
         checksum = checksum + 2 * mod(digit, 5) + digit / 5
      else
         checksum = checksum + digit
      end if
   end subroutine update

end module luhn
