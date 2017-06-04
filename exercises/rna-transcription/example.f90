module rna_transcription
  contains
  function complement(dna)
      implicit none
      character(*) :: dna
      character(len(dna)) :: complement
      integer :: i

      do i = 1,len(dna)
        select case (dna(i:i))
            case ('G')
                complement(i:i) = 'C'
            case ('C')
                complement(i:i) = 'G'
            case ('T')
                complement(i:i) = 'A'
            case ('A')
                complement(i:i) = 'U'
            case default
                complement = ''
                return
        end select
      end do

  end function complement
end module rna_transcription

