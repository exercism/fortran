
! This test was created from ..\problem-specifications\exercises\allergies\canonical-data.json
!

program allergies_test_main
  use TesterMain
  use allergies
  implicit none

  ! Test 1: not allergic to anything
  ! UUID 1: 17fc7296-2440-4ac4-ad7b-d07c321bc5a0
  call assert_equal(.false., allergicTo("eggs", 0), "not allergic to anything")
  ! Test 2: allergic only to eggs
  ! UUID 2: 07ced27b-1da5-4c2e-8ae2-cb2791437546
  call assert_equal(.true., allergicTo("eggs", 1), "allergic only to eggs")
  ! Test 3: allergic to eggs and something else
  ! UUID 3: 5035b954-b6fa-4b9b-a487-dae69d8c5f96
  call assert_equal(.true., allergicTo("eggs", 3), "allergic to eggs and something else")
  ! Test 4: allergic to something, but not eggs
  ! UUID 4: 64a6a83a-5723-4b5b-a896-663307403310
  call assert_equal(.false., allergicTo("eggs", 2), "allergic to something, but not eggs")
  ! Test 5: allergic to everything
  ! UUID 5: 90c8f484-456b-41c4-82ba-2d08d93231c6
  call assert_equal(.true., allergicTo("eggs", 255), "allergic to everything")
  ! Test 1: not allergic to anything
  ! UUID 1: d266a59a-fccc-413b-ac53-d57cb1f0db9d
  call assert_equal(.false., allergicTo("peanuts", 0), "not allergic to anything")
  ! Test 2: allergic only to peanuts
  ! UUID 2: ea210a98-860d-46b2-a5bf-50d8995b3f2a
  call assert_equal(.true., allergicTo("peanuts", 2), "allergic only to peanuts")
  ! Test 3: allergic to peanuts and something else
  ! UUID 3: eac69ae9-8d14-4291-ac4b-7fd2c73d3a5b
  call assert_equal(.true., allergicTo("peanuts", 7), "allergic to peanuts and something else")
  ! Test 4: allergic to something, but not peanuts
  ! UUID 4: 9152058c-ce39-4b16-9b1d-283ec6d25085
  call assert_equal(.false., allergicTo("peanuts", 5), "allergic to something, but not peanuts")
  ! Test 5: allergic to everything
  ! UUID 5: d2d71fd8-63d5-40f9-a627-fbdaf88caeab
  call assert_equal(.true., allergicTo("peanuts", 255), "allergic to everything")
  ! Test 1: not allergic to anything
  ! UUID 1: b948b0a1-cbf7-4b28-a244-73ff56687c80
  call assert_equal(.false., allergicTo("shellfish", 0), "not allergic to anything")
  ! Test 2: allergic only to shellfish
  ! UUID 2: 9ce9a6f3-53e9-4923-85e0-73019047c567
  call assert_equal(.true., allergicTo("shellfish", 4), "allergic only to shellfish")
  ! Test 3: allergic to shellfish and something else
  ! UUID 3: b272fca5-57ba-4b00-bd0c-43a737ab2131
  call assert_equal(.true., allergicTo("shellfish", 14), "allergic to shellfish and something else")
  ! Test 4: allergic to something, but not shellfish
  ! UUID 4: 21ef8e17-c227-494e-8e78-470a1c59c3d8
  call assert_equal(.false., allergicTo("shellfish", 10), "allergic to something, but not shellfish")
  ! Test 5: allergic to everything
  ! UUID 5: cc789c19-2b5e-4c67-b146-625dc8cfa34e
  call assert_equal(.true., allergicTo("shellfish", 255), "allergic to everything")
  ! Test 1: not allergic to anything
  ! UUID 1: 651bde0a-2a74-46c4-ab55-02a0906ca2f5
  call assert_equal(.false., allergicTo("strawberries", 0), "not allergic to anything")
  ! Test 2: allergic only to strawberries
  ! UUID 2: b649a750-9703-4f5f-b7f7-91da2c160ece
  call assert_equal(.true., allergicTo("strawberries", 8), "allergic only to strawberries")
  ! Test 3: allergic to strawberries and something else
  ! UUID 3: 50f5f8f3-3bac-47e6-8dba-2d94470a4bc6
  call assert_equal(.true., allergicTo("strawberries", 28), "allergic to strawberries and something else")
  ! Test 4: allergic to something, but not strawberries
  ! UUID 4: 23dd6952-88c9-48d7-a7d5-5d0343deb18d
  call assert_equal(.false., allergicTo("strawberries", 20), "allergic to something, but not strawberries")
  ! Test 5: allergic to everything
  ! UUID 5: 74afaae2-13b6-43a2-837a-286cd42e7d7e
  call assert_equal(.true., allergicTo("strawberries", 255), "allergic to everything")
  ! Test 1: not allergic to anything
  ! UUID 1: c49a91ef-6252-415e-907e-a9d26ef61723
  call assert_equal(.false., allergicTo("tomatoes", 0), "not allergic to anything")
  ! Test 2: allergic only to tomatoes
  ! UUID 2: b69c5131-b7d0-41ad-a32c-e1b2cc632df8
  call assert_equal(.true., allergicTo("tomatoes", 16), "allergic only to tomatoes")
  ! Test 3: allergic to tomatoes and something else
  ! UUID 3: 1ca50eb1-f042-4ccf-9050-341521b929ec
  call assert_equal(.true., allergicTo("tomatoes", 56), "allergic to tomatoes and something else")
  ! Test 4: allergic to something, but not tomatoes
  ! UUID 4: e9846baa-456b-4eff-8025-034b9f77bd8e
  call assert_equal(.false., allergicTo("tomatoes", 40), "allergic to something, but not tomatoes")
  ! Test 5: allergic to everything
  ! UUID 5: b2414f01-f3ad-4965-8391-e65f54dad35f
  call assert_equal(.true., allergicTo("tomatoes", 255), "allergic to everything")
  ! Test 1: not allergic to anything
  ! UUID 1: 978467ab-bda4-49f7-b004-1d011ead947c
  call assert_equal(.false., allergicTo("chocolate", 0), "not allergic to anything")
  ! Test 2: allergic only to chocolate
  ! UUID 2: 59cf4e49-06ea-4139-a2c1-d7aad28f8cbc
  call assert_equal(.true., allergicTo("chocolate", 32), "allergic only to chocolate")
  ! Test 3: allergic to chocolate and something else
  ! UUID 3: b0a7c07b-2db7-4f73-a180-565e07040ef1
  call assert_equal(.true., allergicTo("chocolate", 112), "allergic to chocolate and something else")
  ! Test 4: allergic to something, but not chocolate
  ! UUID 4: f5506893-f1ae-482a-b516-7532ba5ca9d2
  call assert_equal(.false., allergicTo("chocolate", 80), "allergic to something, but not chocolate")
  ! Test 5: allergic to everything
  ! UUID 5: 02debb3d-d7e2-4376-a26b-3c974b6595c6
  call assert_equal(.true., allergicTo("chocolate", 255), "allergic to everything")
  ! Test 1: not allergic to anything
  ! UUID 1: 17f4a42b-c91e-41b8-8a76-4797886c2d96
  call assert_equal(.false., allergicTo("pollen", 0), "not allergic to anything")
  ! Test 2: allergic only to pollen
  ! UUID 2: 7696eba7-1837-4488-882a-14b7b4e3e399
  call assert_equal(.true., allergicTo("pollen", 64), "allergic only to pollen")
  ! Test 3: allergic to pollen and something else
  ! UUID 3: 9a49aec5-fa1f-405d-889e-4dfc420db2b6
  call assert_equal(.true., allergicTo("pollen", 224), "allergic to pollen and something else")
  ! Test 4: allergic to something, but not pollen
  ! UUID 4: 3cb8e79f-d108-4712-b620-aa146b1954a9
  call assert_equal(.false., allergicTo("pollen", 160), "allergic to something, but not pollen")
  ! Test 5: allergic to everything
  ! UUID 5: 1dc3fe57-7c68-4043-9d51-5457128744b2
  call assert_equal(.true., allergicTo("pollen", 255), "allergic to everything")
  ! Test 1: not allergic to anything
  ! UUID 1: d3f523d6-3d50-419b-a222-d4dfd62ce314
  call assert_equal(.false., allergicTo("cats", 0), "not allergic to anything")
  ! Test 2: allergic only to cats
  ! UUID 2: eba541c3-c886-42d3-baef-c048cb7fcd8f
  call assert_equal(.true., allergicTo("cats", 128), "allergic only to cats")
  ! Test 3: allergic to cats and something else
  ! UUID 3: ba718376-26e0-40b7-bbbe-060287637ea5
  call assert_equal(.true., allergicTo("cats", 192), "allergic to cats and something else")
  ! Test 4: allergic to something, but not cats
  ! UUID 4: 3c6dbf4a-5277-436f-8b88-15a206f2d6c4
  call assert_equal(.false., allergicTo("cats", 64), "allergic to something, but not cats")
  ! Test 5: allergic to everything
  ! UUID 5: 1faabb05-2b98-4995-9046-d83e4a48a7c1
  call assert_equal(.true., allergicTo("cats", 255), "allergic to everything")
  ! Test 1: no allergies
  ! UUID 1: f9c1b8e7-7dc5-4887-aa93-cebdcc29dd8f
  call assert_equal([], list(0), "no allergies")
  ! Test 2: just eggs
  ! UUID 2: 9e1a4364-09a6-4d94-990f-541a94a4c1e8
  call assert_equal(['eggs'], list(1), "just eggs")
  ! Test 3: just peanuts
  ! UUID 3: 8851c973-805e-4283-9e01-d0c0da0e4695
  call assert_equal(['peanuts'], list(2), "just peanuts")
  ! Test 4: just strawberries
  ! UUID 4: 2c8943cb-005e-435f-ae11-3e8fb558ea98
  call assert_equal(['strawberries'], list(8), "just strawberries")
  ! Test 5: eggs and peanuts
  ! UUID 5: 6fa95d26-044c-48a9-8a7b-9ee46ec32c5c
  call assert_equal(['eggs', 'peanuts'], list(3), "eggs and peanuts")
  ! Test 6: more than eggs but not peanuts
  ! UUID 6: 19890e22-f63f-4c5c-a9fb-fb6eacddfe8e
  call assert_equal(['eggs', 'shellfish'], list(5), "more than eggs but not peanuts")
  ! Test 7: lots of stuff
  ! UUID 7: 4b68f470-067c-44e4-889f-c9fe28917d2f
  call assert_equal(['strawberries', 'tomatoes', 'chocolate', 'pollen', 'cats'], list(248), "lots of stuff")
  ! Test 8: everything
  ! UUID 8: 0881b7c5-9efa-4530-91bd-68370d054bc7
  call assert_equal(['eggs', 'peanuts', 'shellfish', 'strawberries', 'tomatoes', 'chocolate', 'pollen', 'cats'], list(255), "everything")
  ! Test 9: no allergen score parts
  ! UUID 9: 12ce86de-b347-42a0-ab7c-2e0570f0c65b
  call assert_equal(['eggs', 'shellfish', 'strawberries', 'tomatoes', 'chocolate', 'pollen', 'cats'], list(509), "no allergen score parts")

  call test_report()

end program

