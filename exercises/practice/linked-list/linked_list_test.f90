! The tests were created from https://github.com/exercism/problem-specifications/blob/main/exercises/linked-list/canonical-data.json

program linked_list_test_main
  use TesterMain
  use linked_list
  implicit none

  type(list_t) :: test_list
  integer :: temp_results(5)

  ! Test 1: pop gets element from the list
  test_list = new()
  call push(test_list, 7)
  call assert_equal(7, pop(test_list), &
    "pop gets element from the list")

  ! Test 2: push/pop respectively add/remove at the end of the list
  test_list = new()
  temp_results = -1
  call push(test_list, 11)
  call push(test_list, 13)
  temp_results(1) = pop(test_list)
  temp_results(2) = pop(test_list)
  call assert_equal([13, 11], temp_results(1:2), &
    "push/pop respectively add/remove at the end of the list")

  ! Test 3: shift gets an element from the list
  test_list = new()
  call push(test_list, 17)
  call assert_equal(17, shift(test_list), &
    "shift gets an element from the list")

  ! Test 4: shift gets first element from the list
  test_list = new()
  temp_results = -1
  call push(test_list, 23)
  call push(test_list, 5)
  temp_results(1) = shift(test_list)
  temp_results(2) = shift(test_list)
  call assert_equal([23, 5], temp_results(1:2), &
    "shift gets first element from the list")

  ! Test 5: unshift adds element at start of the list
  test_list = new()
  temp_results = -1
  call unshift(test_list, 23)
  call unshift(test_list, 5)
  temp_results(1) = shift(test_list)
  temp_results(2) = shift(test_list)
  call assert_equal([5, 23], temp_results(1:2), &
    "unshift adds element at start of the list")

  ! Test 6: pop, push, shift, and unshift can be used in any order
  test_list = new()
  temp_results = -1
  call push(test_list, 1)
  call push(test_list, 2)
  temp_results(1) = pop(test_list)
  call push(test_list, 3)
  temp_results(2) = shift(test_list)
  call unshift(test_list, 4)
  call push(test_list, 5)
  temp_results(3) = shift(test_list)
  temp_results(4) = pop(test_list)
  temp_results(5) = shift(test_list)
  call assert_equal([2, 1, 4, 5, 3], temp_results, &
    "pop, push, shift, and unshift can be used in any order")

  ! Test 7: count an empty list
  test_list = new()
  call assert_equal(0, length(test_list), &
    "count an empty list")

  ! Test 8: count a list with items
  test_list = new()
  temp_results = -1
  call push(test_list, 37)
  call push(test_list, 1)
  temp_results(1) = length(test_list)
  call destroy(test_list)
  temp_results(2) = length(test_list)
  call assert_equal([2, 0], temp_results(1:2), &
    "count a list with items")

  ! Test 9: count is correct after mutation
  test_list = new()
  temp_results = -1
  call push(test_list, 31)
  temp_results(1) = length(test_list)
  call unshift(test_list, 43)
  temp_results(2) = length(test_list)
  temp_results(5) = shift(test_list)
  temp_results(3) = length(test_list)
  temp_results(5) = pop(test_list)
  temp_results(4) = length(test_list)
  call assert_equal([1, 2, 1, 0], temp_results(1:4), &
    "count is correct after mutation")

  ! Test 10: popping to empty doesn't break the list
  test_list = new()
  temp_results = -1
  call push(test_list, 41)
  call push(test_list, 59)
  temp_results(5) = pop(test_list)
  temp_results(5) = pop(test_list)
  call push(test_list, 47)
  temp_results(1) = length(test_list)
  temp_results(2) = pop(test_list)
  call destroy(test_list)
  temp_results(3) = length(test_list)
  call assert_equal([1, 47, 0], temp_results(1:3), &
    "popping to empty doesn't break the list")

  ! Test 11: shifting to empty doesn't break the list
  test_list = new()
  temp_results = -1
  call push(test_list, 41)
  call push(test_list, 59)
  temp_results(5) = shift(test_list)
  temp_results(5) = shift(test_list)
  call push(test_list, 47)
  temp_results(1) = length(test_list)
  temp_results(2) = shift(test_list)
  call destroy(test_list)
  temp_results(3) = length(test_list)
  call assert_equal([1, 47, 0], temp_results(1:3), &
    "shifting to empty doesn't break the list")

  ! Test 12: deletes the only element
  test_list = new()
  call push(test_list, 61)
  call delete(test_list, 61)
  call assert_equal(0, length(test_list), &
    "deletes the only element")

  ! Test 13: deletes the element with the specified value from the list
  test_list = new()
  temp_results = -1
  call push(test_list, 71)
  call push(test_list, 83)
  call push(test_list, 79)
  call delete(test_list, 83)
  temp_results(1) = length(test_list)
  temp_results(2) = pop(test_list)
  temp_results(3) = shift(test_list)
  call assert_equal([2, 79, 71], temp_results(1:3), &
    "deletes the element with the specified value from the list")

  ! Test 14: deletes the element with the specified value from the list, re-assigns tail
  test_list = new()
  temp_results = -1
  call push(test_list, 71)
  call push(test_list, 83)
  call push(test_list, 79)
  call delete(test_list, 83)
  temp_results(1) = length(test_list)
  temp_results(2) = pop(test_list)
  temp_results(3) = pop(test_list)
  call assert_equal([2, 79, 71], temp_results(1:3), &
    "deletes the element with the specified value from the list, re-assigns tail")

  ! Test 15: deletes the element with the specified value from the list, re-assigns head
  test_list = new()
  temp_results = -1
  call push(test_list, 71)
  call push(test_list, 83)
  call push(test_list, 79)
  call delete(test_list, 83)
  temp_results(1) = length(test_list)
  temp_results(2) = shift(test_list)
  temp_results(3) = shift(test_list)
  call assert_equal([2, 71, 79], temp_results(1:3), &
    "deletes the element with the specified value from the list, re-assigns head")

  ! Test 16: deletes the first of two elements
  test_list = new()
  temp_results = -1
  call push(test_list, 97)
  call push(test_list, 101)
  call delete(test_list, 97)
  temp_results(1) = length(test_list)
  temp_results(2) = pop(test_list)
  call destroy(test_list)
  temp_results(3) = length(test_list)
  call assert_equal([1, 101, 0], temp_results(1:3), &
    "deletes the first of two elements")

  ! Test 17: deletes the second of two elements
  test_list = new()
  temp_results = -1
  call push(test_list, 97)
  call push(test_list, 101)
  call delete(test_list, 101)
  temp_results(1) = length(test_list)
  temp_results(2) = pop(test_list)
  call destroy(test_list)
  temp_results(3) = length(test_list)
  call assert_equal([1, 97, 0], temp_results(1:3), &
    "deletes the second of two elements")

  ! Test 18: delete does not modify the list if the element is not found
  test_list = new()
  temp_results = -1
  call delete(test_list, 103)
  temp_results(1) = length(test_list)
  call push(test_list, 89)
  call delete(test_list, 103)
  temp_results(2) = length(test_list)
  temp_results(3) = pop(test_list)
  call assert_equal([0, 1, 89], temp_results(1:3), &
    "delete does not modify the list if the element is not found")

  ! Test 19: deletes only the first occurrence
  test_list = new()
  temp_results = -1
  call push(test_list, 73)
  call push(test_list, 9)
  call push(test_list, 113)
  call push(test_list, 9)
  call push(test_list, 107)
  call delete(test_list, 9)
  temp_results(1) = length(test_list)
  temp_results(2) = pop(test_list)
  temp_results(3) = pop(test_list)
  temp_results(4) = pop(test_list)
  temp_results(5) = pop(test_list)
  call assert_equal([4, 107, 9, 113, 73], temp_results, &
    "deletes only the first occurrence")

  call test_report()

end program
