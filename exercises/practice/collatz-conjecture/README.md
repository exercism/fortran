# Collatz Conjecture

The Collatz Conjecture or 3x+1 problem can be summarized as follows:

Take any positive integer n. If n is even, divide n by 2 to get n / 2. If n is
odd, multiply n by 3 and add 1 to get 3n + 1. Repeat the process indefinitely.
The conjecture states that no matter which number you start with, you will
always reach 1 eventually.

Given a number n, return the number of steps required to reach 1.

## Examples

Starting with n = 12, the steps would be as follows:

0. 12
1. 6
2. 3
3. 10
4. 5
5. 16
6. 8
7. 4
8. 2
9. 1

Resulting in 9 steps. So for input n = 12, the return value would be 9.


## Source

An unsolved problem in mathematics named after mathematician Lothar Collatz [https://en.wikipedia.org/wiki/3x_%2B_1_problem](https://en.wikipedia.org/wiki/3x_%2B_1_problem)

## Getting Started

Make sure you have read the [Installation](https://exercism.io/tracks/fortran/installation) and [Running the tests](https://exercism.io/tracks/fortran/tests) pages for Fortran on exercism.io.
This covers the basic information on setting up the development environment expected by the exercises.

## Passing the tests

Get the first test compiling, linking and passing by following the [three rules of test-driven development](http://butunclebob.com/ArticleS.UncleBob.TheThreeRulesOfTdd).

The tests are in `collatz_conjecture_test.f90` and they expect the implementation to be in `collatz_conjecture.f90`.
In case the file `collatz_conjecture.f90` does not exist, create the file with the content:

```c
module collatz_conjecture
  implicit none
contains

  ! Create your function here

end module collatz_conjecture
```

Now create a build directory (eg. `mkdir build`), change into it and run `cmake ..`  to configure the build.

Note, that the first time you call `cmake ..` it will download the `testlib` automatically which is used in `collatz_conjecture_test.f90`.

The `testib` can also be downloaded manually from github. For more information see [Running the tests](https://exercism.io/tracks/fortran/tests).

Now build (eg. `make`)  and run tests with `ctest -V`. For a detailed description see [Running the Tests](https://exercism.io/tracks/fortran/tests).

At first all test will fail.
To disable a certain test, simply comment it out with '!', eg.

```c
  ! Test 16: non-letters with question
  ! call assert_equal("Sure.", hey(":) ?"), "non-letters with question")
```

## Submitting Incomplete Solutions
It's possible to submit an incomplete solution so you can see how others have completed the exercise.
