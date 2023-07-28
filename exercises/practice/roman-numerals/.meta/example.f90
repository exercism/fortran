module roman_numerals
  implicit none

  type :: numeral_t
    character(2) :: letter
    integer :: val
  end type numeral_t

  type(numeral_t), dimension(13), parameter :: numerals = [ &
    numeral_t(letter = 'M', val = 1000), &
    numeral_t(letter = 'CM', val = 900), &
    numeral_t(letter = 'D', val = 500), &
    numeral_t(letter = 'CD', val = 400), &
    numeral_t(letter = 'C', val = 100), &
    numeral_t(letter = 'XC', val = 90), &
    numeral_t(letter = 'L', val = 50), &
    numeral_t(letter = 'XL', val = 40), &
    numeral_t(letter = 'X', val = 10), &
    numeral_t(letter = 'IX', val = 9), &
    numeral_t(letter = 'V', val = 5), &
    numeral_t(letter = 'IV', val = 4), &
    numeral_t(letter = 'I', val = 1)]

contains

  function roman(num) result(s)
    integer, value :: num
    character(15) :: s
    integer :: i

    s = ''
    do i = 1, size(numerals)
      associate (letter => numerals(i)%letter, val => numerals(i)%val)
        do while (val <= num)
          s = trim(s) // letter
          num = num - val
        end do
      end associate
    end do
  end function roman

end module roman_numerals
