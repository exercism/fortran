module protein_translation
  implicit none

! | Codon              | Protein       |
! | :----------------- | :------------ |
! | AUG                | Methionine    |
! | UUU, UUC           | Phenylalanine |
! | UUA, UUG           | Leucine       |
! | UCU, UCC, UCA, UCG | Serine        |
! | UAU, UAC           | Tyrosine      |
! | UGU, UGC           | Cysteine      |
! | UGG                | Tryptophan    |
! | UAA, UAG, UGA      | STOP          |

  character(len=13), private :: protein_names(7) = [&
    "Methionine   ", &
    "Phenylalanine", &
    "Leucine      ", &
    "Serine       ", &
    "Tyrosine     ", &
    "Cysteine     ", &
    "Tryptophan   " &
    ]

contains

  function proteins(rna) result(names)
    character(len=*), intent(in) :: rna
    integer, allocatable :: protein_ids(:)
    character(len=13), allocatable :: names(:)
    integer :: i, n_protein, max_n_proteins
    
    max_n_proteins = len(rna)/3
    allocate(protein_ids(0:max_n_proteins-1))

    n_protein = 0
    do i = 1, len(rna), 3
      if (i + 2 > len(rna)) STOP "Invalid codon"
      select case (rna(i:i+2))
        case ("AUG") 
          protein_ids(n_protein+1) = 1
        case ("UUU", "UUC")
          protein_ids(n_protein+1) = 2
        case ("UUA", "UUG")
          protein_ids(n_protein+1) = 3
        case ("UCU", "UCC", "UCA", "UCG")
          protein_ids(n_protein+1) = 4
        case ("UAU", "UAC")
          protein_ids(n_protein+1) = 5
        case ("UGU", "UGC")
          protein_ids(n_protein+1) = 6
        case ("UGG")
          protein_ids(n_protein+1) = 7
        case ("UAA", "UAG", "UGA")
          EXIT
        case default
          STOP "Invalid codon"
      end select
      n_protein = n_protein + 1
    end do

    allocate(names(n_protein))
    do i = 1, n_protein
      names(i) = protein_names(protein_ids(i))
    end do

  end function proteins

end module protein_translation

