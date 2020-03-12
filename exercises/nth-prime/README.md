# Nth Prime

Given a number n, determine what the nth prime is.

By listing the first six prime numbers: 2, 3, 5, 7, 11, and 13, we can see that
the 6th prime is 13.

If your language provides methods in the standard library to deal with prime
numbers, pretend they don't exist and implement them yourself.


## Source

A variation on Problem 7 at Project Euler [http://projecteuler.net/problem=7](http://projecteuler.net/problem=7)

## Getting Started

Make sure you have read the [Installation](https://exercism.io/tracks/fortran/installation) and [Running the tests](https://exercism.io/tracks/fortran/tests) pages for Fortran on exercism.io.
This covers the basic information on setting up the development environment expected by the exercises.

## Passing the tests

Get the first test compiling, linking and passing by following the [three rules of test-driven development](http://butunclebob.com/ArticleS.UncleBob.TheThreeRulesOfTdd).

The tests are in `nth_prime_test.f90` and they expect the implementation to be in `nth_prime.f90`.
In case the file `nth_prime.f90` does not exist, create the file with the content:

```c
module nth_prime
  implicit none
contains

  ! Create your function here

end module nth_prime
```

Now create a build directory (eg. `mkdir build`), change into it and run `cmake ..`  to configure the build.

Note, that the first time you call `cmake ..` it will download the `testlib` automatically which is used in `nth_prime_test.f90`.

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
