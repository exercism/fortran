# Difference Of Squares

Find the difference between the square of the sum and the sum of the squares of the first N natural numbers.

The square of the sum of the first ten natural numbers is
(1 + 2 + ... + 10)² = 55² = 3025.

The sum of the squares of the first ten natural numbers is
1² + 2² + ... + 10² = 385.

Hence the difference between the square of the sum of the first
ten natural numbers and the sum of the squares of the first ten
natural numbers is 3025 - 385 = 2640.

You are not expected to discover an efficient solution to this yourself from
first principles; research is allowed, indeed, encouraged. Finding the best
algorithm for the problem is a key skill in software engineering.


## Source

Problem 6 at Project Euler [http://projecteuler.net/problem=6](http://projecteuler.net/problem=6)

## Getting Started

Make sure you have read the [Installation](https://exercism.io/tracks/fortran/installation) and [Running the tests](https://exercism.io/tracks/fortran/tests) pages for Fortran on exercism.io.
This covers the basic information on setting up the development environment expected by the exercises.

## Passing the tests

Get the first test compiling, linking and passing by following the [three rules of test-driven development](http://butunclebob.com/ArticleS.UncleBob.TheThreeRulesOfTdd).

The tests are in `difference_of_squares_test.f90` and they expect the implementation to be in `difference_of_squares.f90`.
In case the file `difference_of_squares.f90` does not exist, create the file with the content:

```c
module difference_of_squares
  implicit none
contains

  ! Create your function here

end module difference_of_squares
```

Now create a build directory (eg. `mkdir Debug`), change into it and run `cmake ..`  to configure the build.

Note, that the first time you call `cmake ..` it will download the `testlib` automatically which is used in `difference_of_squares_test.f90`.

The `testib` can also be downloaded manually from github see 

Now build (eg. `make`)  and run tests with `ctest -V`. For a detailed description see [Running the Tests](https://exercism.io/tracks/fortran/tests).

At first all test will fail.
To disable a certain test, simply comment it out with '!', eg.

```c
  ! Test 16: non-letters with question
  ! call assert_equal("Sure.", hey(":) ?"), "non-letters with question")
```

## Submitting Incomplete Solutions
It's possible to submit an incomplete solution so you can see how others have completed the exercise.
