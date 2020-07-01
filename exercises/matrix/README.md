# Matrix

Given a string representing a matrix of numbers, return the rows and columns of
that matrix.

So given a list of strings:

```text
9, 8, 7
5, 3, 2
6, 6, 7
```

representing this matrix:

```text
    1  2  3
  |---------
1 | 9  8  7
2 | 5  3  2
3 | 6  6  7
```

your code should be able to spit out:

- A list of the rows, reading each row left-to-right while moving
  top-to-bottom across the rows,
- A list of the columns, reading each column top-to-bottom while moving
  from left-to-right.

The rows for our example matrix:

- 9, 8, 7
- 5, 3, 2
- 6, 6, 7

And its columns:

- 9, 5, 6
- 8, 3, 6
- 7, 2, 7

### Hint

Comma separated strings `(character(len=*))` can be easily read in fortran by defining an integer array and using the intrisic `read` function.

## Source

Warmup to the `saddle-points` warmup. [http://jumpstartlab.com](http://jumpstartlab.com)

## Getting Started

Make sure you have read the [Installation](https://exercism.io/tracks/fortran/installation) and [Running the tests](https://exercism.io/tracks/fortran/tests) pages for Fortran on exercism.io.
This covers the basic information on setting up the development environment expected by the exercises.

## Passing the tests

Get the first test compiling, linking and passing by following the [three rules of test-driven development](http://butunclebob.com/ArticleS.UncleBob.TheThreeRulesOfTdd).

The tests are in `matrix_test.f90` and they expect the implementation to be in `matrix.f90`.
In case the file `matrix.f90` does not exist, create the file with the content:

```c
module matrix
  implicit none
contains

  ! Create your function here

end module matrix
```

Now create a build directory (eg. `mkdir build`), change into it and run `cmake ..`  to configure the build.

Note, that the first time you call `cmake ..` it will download the `testlib` automatically which is used in `matrix_test.f90`.

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
