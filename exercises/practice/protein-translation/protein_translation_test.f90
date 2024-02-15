! The tests were created from https://github.com/exercism/problem-specifications/blob/main/exercises/protein-translation/canonical-data.json

program protein_translation_test_main
  use TesterMain
  use protein_translation
  implicit none

  ! Test 1: Empty RNA sequence results in no proteins
  call assert_equal([character(len=13) ::], proteins(""), "Empty RNA sequence results in no proteins")

  ! Test 2: Methionine RNA sequence
  call assert_equal([character(len=13) :: 'Methionine'], proteins("AUG"), "Methionine RNA sequence")

  ! Test 3: Phenylalanine RNA sequence 1
  call assert_equal([character(len=13) :: 'Phenylalanine'], proteins("UUU"), "Phenylalanine RNA sequence 1")

  ! Test 4: Phenylalanine RNA sequence 2
  call assert_equal([character(len=13) :: 'Phenylalanine'], proteins("UUC"), "Phenylalanine RNA sequence 1")

  ! Test 5: Leucine RNA sequence 1
  call assert_equal([character(len=13) :: 'Leucine'], proteins("UUA"), "Leucine RNA sequence 1")

  ! Test 6: Leucine RNA sequence 2
  call assert_equal([character(len=13) :: 'Leucine'], proteins("UUG"), "Leucine RNA sequence 1")

  ! Test 7: Serine RNA sequence 1
  call assert_equal([character(len=13) :: 'Serine'], proteins("UCU"), "Serine RNA sequence 1")

  ! Test 8: Serine RNA sequence 2
  call assert_equal([character(len=13) :: 'Serine'], proteins("UCC"), "Serine RNA sequence 2")

  ! Test 9: Serine RNA sequence 3
  call assert_equal([character(len=13) :: 'Serine'], proteins("UCA"), "Serine RNA sequence 3")

  ! Test 10: Serine RNA sequence 4
  call assert_equal([character(len=13) :: 'Serine'], proteins("UCG"), "Serine RNA sequence 4")

  ! Test 11: Tyrosine RNA sequence 1
  call assert_equal([character(len=13) :: 'Tyrosine'], proteins("UAU"), "Tyrosine RNA sequence 1")

  ! Test 12: Tyrosine RNA sequence 2
  call assert_equal([character(len=13) :: 'Tyrosine'], proteins("UAC"), "Tyrosine RNA sequence 2")

  ! Test 13: Cysteine RNA sequence 1
  call assert_equal([character(len=13) :: 'Cysteine'], proteins("UGU"), "Cysteine RNA sequence 1")

  ! Test 14: Cysteine RNA sequence 2
  call assert_equal([character(len=13) :: 'Cysteine'], proteins("UGC"), "Cysteine RNA sequence 2")

  ! Test 15: Tryptophan RNA sequence
  call assert_equal([character(len=13) :: 'Tryptophan'], proteins("UGG"), "Tryptophan RNA sequence")

  ! Test 16: STOP codon RNA sequence 1
  call assert_equal([character(len=13) :: ], proteins("UAA"), "STOP codon RNA sequence 1")

  ! Test 17: STOP codon RNA sequence 2
  call assert_equal([character(len=13) :: ], proteins("UAG"), "STOP codon RNA sequence 2")

  ! Test 18: STOP codon RNA sequence 3
  call assert_equal([character(len=13) :: ], proteins("UGA"), "STOP codon RNA sequence 3")

  ! Test 19: Sequence of two protein codons translates into proteins
  call assert_equal([character(len=13) :: 'Phenylalanine', 'Phenylalanine'], proteins("UUUUUU"), &
    "Sequence of two protein codons translates into proteins")

  ! Test 20: Sequence of two different protein codons translates into proteins
  call assert_equal([character(len=13) :: 'Leucine', 'Leucine'], proteins("UUAUUG"), &
    "Sequence of two different protein codons translates into proteins")

  ! Test 21: Translate RNA strand into correct protein list
  call assert_equal([character(len=13) :: 'Methionine', 'Phenylalanine', 'Tryptophan'], &
    proteins("AUGUUUUGG"), "Translate RNA strand into correct protein list")

  ! Test 22: Translation stops if STOP codon at beginning of sequence
  call assert_equal([character(len=13) :: ], proteins("UAGUGG"), &
    "Translation stops if STOP codon at beginning of sequence")

  ! Test 23: Translation stops if STOP codon at end of two-codon sequence
  call assert_equal([character(len=13) :: 'Tryptophan'], proteins("UGGUAG"), &
    "Translation stops if STOP codon at end of two-codon sequence")

  ! Test 24: Translation stops if STOP codon at end of three-codon sequence
  call assert_equal([character(len=13) :: 'Methionine', 'Phenylalanine'], proteins("AUGUUUUAA"), &
    "Translation stops if STOP codon at end of three-codon sequence")

  ! Test 25: Translation stops if STOP codon in middle of three-codon sequence
  call assert_equal([character(len=13) :: 'Tryptophan'], proteins("UGGUAGUGG"), &
    "Translation stops if STOP codon in middle of three-codon sequence")

  ! Test 26: Translation stops if STOP codon in middle of six-codon sequence
  call assert_equal([character(len=13) :: 'Tryptophan', 'Cysteine', 'Tyrosine'], &
    proteins("UGGUGUUAUUAAUGGUUU"), &
    "Translation stops if STOP codon in middle of six-codon sequence")

  call test_report()

end program protein_translation_test_main

