
! This test was created from ..\problem-specifications\exercises\yacht\canonical-data.json
!

program yacht_test_main
  use TesterMain
  use yacht
  implicit none

  ! Test 1: Yacht
  ! UUID 1: 3060e4a5-4063-4deb-a380-a630b43a84b6
  call assert_equal(50, score([5, 5, 5, 5, 5], "yacht"), "Yacht")
  ! Test 2: Not Yacht
  ! UUID 2: 15026df2-f567-482f-b4d5-5297d57769d9
  call assert_equal(0, score([1, 3, 3, 2, 5], "yacht"), "Not Yacht")
  ! Test 3: Ones
  ! UUID 3: 36b6af0c-ca06-4666-97de-5d31213957a4
  call assert_equal(3, score([1, 1, 1, 3, 5], "ones"), "Ones")
  ! Test 4: Ones, out of order
  ! UUID 4: 023a07c8-6c6e-44d0-bc17-efc5e1b8205a
  call assert_equal(3, score([3, 1, 1, 5, 1], "ones"), "Ones, out of order")
  ! Test 5: No ones
  ! UUID 5: 7189afac-cccd-4a74-8182-1cb1f374e496
  call assert_equal(0, score([4, 3, 6, 5, 5], "ones"), "No ones")
  ! Test 6: Twos
  ! UUID 6: 793c4292-dd14-49c4-9707-6d9c56cee725
  call assert_equal(2, score([2, 3, 4, 5, 6], "twos"), "Twos")
  ! Test 7: Fours
  ! UUID 7: dc41bceb-d0c5-4634-a734-c01b4233a0c6
  call assert_equal(8, score([1, 4, 1, 4, 1], "fours"), "Fours")
  ! Test 8: Yacht counted as threes
  ! UUID 8: f6125417-5c8a-4bca-bc5b-b4b76d0d28c8
  call assert_equal(15, score([3, 3, 3, 3, 3], "threes"), "Yacht counted as threes")
  ! Test 9: Yacht of 3s counted as fives
  ! UUID 9: 464fc809-96ed-46e4-acb8-d44e302e9726
  call assert_equal(0, score([3, 3, 3, 3, 3], "fives"), "Yacht of 3s counted as fives")
  ! Test 10: Sixes
  ! UUID 10: e8a036e0-9d21-443a-8b5f-e15a9e19a761
  call assert_equal(6, score([2, 3, 4, 5, 6], "sixes"), "Sixes")
  ! Test 11: Full house two small, three big
  ! UUID 11: 51cb26db-6b24-49af-a9ff-12f53b252eea
  call assert_equal(16, score([2, 2, 4, 4, 4], "full house"), "Full house two small, three big")
  ! Test 12: Full house three small, two big
  ! UUID 12: 1822ca9d-f235-4447-b430-2e8cfc448f0c
  call assert_equal(19, score([5, 3, 3, 5, 3], "full house"), "Full house three small, two big")
  ! Test 13: Two pair is not a full house
  ! UUID 13: b208a3fc-db2e-4363-a936-9e9a71e69c07
  call assert_equal(0, score([2, 2, 4, 4, 5], "full house"), "Two pair is not a full house")
  ! Test 14: Four of a kind is not a full house
  ! UUID 14: b90209c3-5956-445b-8a0b-0ac8b906b1c2
  call assert_equal(0, score([1, 4, 4, 4, 4], "full house"), "Four of a kind is not a full house")
  ! Test 15: Yacht is not a full house
  ! UUID 15: 32a3f4ee-9142-4edf-ba70-6c0f96eb4b0c
  call assert_equal(0, score([2, 2, 2, 2, 2], "full house"), "Yacht is not a full house")
  ! Test 16: Four of a Kind
  ! UUID 16: b286084d-0568-4460-844a-ba79d71d79c6
  call assert_equal(24, score([6, 6, 4, 6, 6], "four of a kind"), "Four of a Kind")
  ! Test 17: Yacht can be scored as Four of a Kind
  ! UUID 17: f25c0c90-5397-4732-9779-b1e9b5f612ca
  call assert_equal(12, score([3, 3, 3, 3, 3], "four of a kind"), "Yacht can be scored as Four of a Kind")
  ! Test 18: Full house is not Four of a Kind
  ! UUID 18: 9f8ef4f0-72bb-401a-a871-cbad39c9cb08
  call assert_equal(0, score([3, 3, 3, 5, 5], "four of a kind"), "Full house is not Four of a Kind")
  ! Test 19: Little Straight
  ! UUID 19: b4743c82-1eb8-4a65-98f7-33ad126905cd
  call assert_equal(30, score([3, 5, 4, 1, 2], "little straight"), "Little Straight")
  ! Test 20: Little Straight as Big Straight
  ! UUID 20: 7ac08422-41bf-459c-8187-a38a12d080bc
  call assert_equal(0, score([1, 2, 3, 4, 5], "big straight"), "Little Straight as Big Straight")
  ! Test 21: Four in order but not a little straight
  ! UUID 21: 97bde8f7-9058-43ea-9de7-0bc3ed6d3002
  call assert_equal(0, score([1, 1, 2, 3, 4], "little straight"), "Four in order but not a little straight")
  ! Test 22: No pairs but not a little straight
  ! UUID 22: cef35ff9-9c5e-4fd2-ae95-6e4af5e95a99
  call assert_equal(0, score([1, 2, 3, 4, 6], "little straight"), "No pairs but not a little straight")
  ! Test 23: Minimum is 1, maximum is 5, but not a little straight
  ! UUID 23: fd785ad2-c060-4e45-81c6-ea2bbb781b9d
  call assert_equal(0, score([1, 1, 3, 4, 5], "little straight"), "Minimum is 1, maximum is 5, but not a little straight")
  ! Test 24: Big Straight
  ! UUID 24: 35bd74a6-5cf6-431a-97a3-4f713663f467
  call assert_equal(30, score([4, 6, 2, 5, 3], "big straight"), "Big Straight")
  ! Test 25: Big Straight as little straight
  ! UUID 25: 87c67e1e-3e87-4f3a-a9b1-62927822b250
  call assert_equal(0, score([6, 5, 4, 3, 2], "little straight"), "Big Straight as little straight")
  ! Test 26: No pairs but not a big straight
  ! UUID 26: c1fa0a3a-40ba-4153-a42d-32bc34d2521e
  call assert_equal(0, score([6, 5, 4, 3, 1], "big straight"), "No pairs but not a big straight")
  ! Test 27: Choice
  ! UUID 27: 207e7300-5d10-43e5-afdd-213e3ac8827d
  call assert_equal(23, score([3, 3, 5, 6, 6], "choice"), "Choice")
  ! Test 28: Yacht as choice
  ! UUID 28: b524c0cf-32d2-4b40-8fb3-be3500f3f135
  call assert_equal(10, score([2, 2, 2, 2, 2], "choice"), "Yacht as choice")

  call test_report()

end program

