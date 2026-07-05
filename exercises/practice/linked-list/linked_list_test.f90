! The tests were created from https://github.com/exercism/problem-specifications/blob/main/exercises/linked-list/canonical-data.json

program linked_list_test_main
  use TesterMain
  use linked_list

  implicit none

  type(list_t) :: test_list
  integer :: unused


  ! Test 1: pop gets element from the list
  test_list = new()
  call push(test_list, 7)
  call assert_equal(7, pop(test_list), &
    "pop gets element from the list")
  call destroy(test_list)

  ! Test 2: push/pop respectively add/remove at the end of the list
  test_list = new()
  call push(test_list, 11)
  call push(test_list, 13)
  call assert_equal(13, pop(test_list), &
    "push/pop respectively add/remove at the end of the list")
  call assert_equal(11, pop(test_list), &
    "push/pop respectively add/remove at the end of the list")
  call destroy(test_list)

  ! Test 3: shift gets an element from the list
  test_list = new()
  call push(test_list, 17)
  call assert_equal(17, shift(test_list), &
    "shift gets an element from the list")
  call destroy(test_list)

  ! Test 4: shift gets first element from the list
  test_list = new()
  call push(test_list, 23)
  call push(test_list, 5)
  call assert_equal(23, shift(test_list), &
    "shift gets first element from the list")
  call assert_equal(5, shift(test_list), &
    "shift gets first element from the list")
  call destroy(test_list)

  ! Test 5: unshift adds element at start of the list
  test_list = new()
  call unshift(test_list, 23)
  call unshift(test_list, 5)
  call assert_equal(5, shift(test_list), &
    "unshift adds element at start of the list")
  call assert_equal(23, shift(test_list), &
    "unshift adds element at start of the list")
  call destroy(test_list)

  ! Test 6: pop, push, shift, and unshift can be used in any order
  test_list = new()
  call push(test_list, 1)
  call push(test_list, 2)
  call assert_equal(2, pop(test_list), &
    "pop, push, shift, and unshift can be used in any order")
  call push(test_list, 3)
  call assert_equal(1, shift(test_list), &
    "pop, push, shift, and unshift can be used in any order")
  call unshift(test_list, 4)
  call push(test_list, 5)
  call assert_equal(4, shift(test_list), &
    "pop, push, shift, and unshift can be used in any order")
  call assert_equal(5, pop(test_list), &
    "pop, push, shift, and unshift can be used in any order")
  call assert_equal(3, shift(test_list), &
    "pop, push, shift, and unshift can be used in any order")
  call destroy(test_list)

  ! Test 7: count an empty list
  test_list = new()
  call assert_equal(0, length(test_list), &
    "count an empty list")
  call destroy(test_list)

  ! Test 8: count a list with items
  test_list = new()
  call push(test_list, 37)
  call push(test_list, 1)
  call assert_equal(2, length(test_list), &
    "count a list with items")
  call destroy(test_list)

  ! Test 9: count is correct after mutation
  test_list = new()
  call push(test_list, 31)
  call assert_equal(1, length(test_list), &
    "count is correct after mutation")
  call unshift(test_list, 43)
  call assert_equal(2, length(test_list), &
    "count is correct after mutation")
  unused = shift(test_list)
  call assert_equal(1, length(test_list), &
    "count is correct after mutation")
  unused = pop(test_list)
  call assert_equal(0, length(test_list), &
    "count is correct after mutation")
  call destroy(test_list)

  ! Test 10: popping to empty doesn't break the list
  test_list = new()
  call push(test_list, 41)
  call push(test_list, 59)
  unused = pop(test_list)
  unused = pop(test_list)
  call push(test_list, 47)
  call assert_equal(1, length(test_list), &
    "popping to empty doesn't break the list")
  call assert_equal(47, pop(test_list), &
    "popping to empty doesn't break the list")
  call destroy(test_list)

  ! Test 11: shifting to empty doesn't break the list
  test_list = new()
  call push(test_list, 41)
  call push(test_list, 59)
  unused = shift(test_list)
  unused = shift(test_list)
  call push(test_list, 47)
  call assert_equal(1, length(test_list), &
    "shifting to empty doesn't break the list")
  call assert_equal(47, shift(test_list), &
    "shifting to empty doesn't break the list")
  call destroy(test_list)

  ! Test 12: deletes the only element
  test_list = new()
  call push(test_list, 61)
  call delete(test_list, 61)
  call assert_equal(0, length(test_list), &
    "deletes the only element")
  call destroy(test_list)

  ! Test 13: deletes the element with the specified value from the list
  test_list = new()
  call push(test_list, 71)
  call push(test_list, 83)
  call push(test_list, 79)
  call delete(test_list, 83)
  call assert_equal(2, length(test_list), &
    "deletes the element with the specified value from the list")
  call assert_equal(79, pop(test_list), &
    "deletes the element with the specified value from the list")
  call assert_equal(71, shift(test_list), &
    "deletes the element with the specified value from the list")
  call destroy(test_list)

  ! Test 14: deletes the element with the specified value from the list, re-assigns tail
  test_list = new()
  call push(test_list, 71)
  call push(test_list, 83)
  call push(test_list, 79)
  call delete(test_list, 83)
  call assert_equal(2, length(test_list), &
    "deletes the element with the specified value from the list, re-assigns tail")
  call assert_equal(79, pop(test_list), &
    "deletes the element with the specified value from the list, re-assigns tail")
  call assert_equal(71, pop(test_list), &
    "deletes the element with the specified value from the list, re-assigns tail")
  call destroy(test_list)

  ! Test 15: deletes the element with the specified value from the list, re-assigns head
  test_list = new()
  call push(test_list, 71)
  call push(test_list, 83)
  call push(test_list, 79)
  call delete(test_list, 83)
  call assert_equal(2, length(test_list), &
    "deletes the element with the specified value from the list, re-assigns head")
  call assert_equal(71, shift(test_list), &
    "deletes the element with the specified value from the list, re-assigns head")
  call assert_equal(79, shift(test_list), &
    "deletes the element with the specified value from the list, re-assigns head")
  call destroy(test_list)

  ! Test 16: deletes the first of two elements
  test_list = new()
  call push(test_list, 97)
  call push(test_list, 101)
  call delete(test_list, 97)
  call assert_equal(1, length(test_list), &
    "deletes the first of two elements")
  call assert_equal(101, pop(test_list), &
    "deletes the first of two elements")
  call destroy(test_list)

  ! Test 17: deletes the second of two elements
  test_list = new()
  call push(test_list, 97)
  call push(test_list, 101)
  call delete(test_list, 101)
  call assert_equal(1, length(test_list), &
    "deletes the second of two elements")
  call assert_equal(97, pop(test_list), &
    "deletes the second of two elements")
  call destroy(test_list)

  ! Test 18: delete does not modify the list if the element is not found
  test_list = new()
  call push(test_list, 89)
  call delete(test_list, 103)
  call assert_equal(1, length(test_list), &
    "delete does not modify the list if the element is not found")
  call destroy(test_list)

  ! Test 19: deletes only the first occurrence
  test_list = new()
  call push(test_list, 73)
  call push(test_list, 9)
  call push(test_list, 9)
  call push(test_list, 107)
  call delete(test_list, 9)
  call assert_equal(3, length(test_list), &
    "deletes only the first occurrence")
  call assert_equal(107, pop(test_list), &
    "deletes only the first occurrence")
  call assert_equal(9, pop(test_list), &
    "deletes only the first occurrence")
  call assert_equal(73, pop(test_list), &
    "deletes only the first occurrence")
  call destroy(test_list)

  call test_report()

end program
