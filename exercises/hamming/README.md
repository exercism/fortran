# Hamming

Calculate the Hamming Distance between two DNA strands.

Your body is made up of cells that contain DNA. Those cells regularly wear out and need replacing, which they achieve by dividing into daughter cells. In fact, the average human body experiences about 10 quadrillion cell divisions in a lifetime!

When cells divide, their DNA replicates too. Sometimes during this process mistakes happen and single pieces of DNA get encoded with the incorrect information. If we compare two strands of DNA and count the differences between them we can see how many mistakes occurred. This is known as the "Hamming Distance".

We read DNA using the letters C,A,G and T. Two strands might look like this:

    GAGCCTACTAACGGGAT
    CATCGTAATGACGGCCT
    ^ ^ ^  ^ ^    ^^

They have 7 differences, and therefore the Hamming Distance is 7.

The Hamming Distance is useful for lots of things in science, not just biology, so it's a nice phrase to be familiar with :)

# Implementation notes

The Hamming distance is only defined for sequences of equal length, so
an attempt to calculate it between sequences of different lengths should
not work. The general handling of this situation (e.g., raising an
exception vs returning a special value) may differ between languages.


## Source

The Calculating Point Mutations problem at Rosalind [http://rosalind.info/problems/hamm/](http://rosalind.info/problems/hamm/)

## Getting Started

Make sure you have read the [Installation](https://exercism.io/tracks/fortran/installation) and [Running the tests](https://exercism.io/tracks/fortran/tests) pages for Fortran on exercism.io.
This covers the basic information on setting up the development environment expected by the exercises.

## Passing the tests

Get the first test compiling, linking and passing by following the [three rules of test-driven development](http://butunclebob.com/ArticleS.UncleBob.TheThreeRulesOfTdd).

The tests are in `hamming_test.f90` and they expect the implementation to be in `hamming.f90`.
In case the file `hamming.f90` does not exist, create the file with the content:

```c
module hamming
  implicit none
contains

  ! Create your function here

end module hamming
```

Now create a build directory (eg. `mkdir build`), change into it and run `cmake ..`  to configure the build.

Note, that the first time you call `cmake ..` it will download the `testlib` automatically which is used in `hamming_test.f90`.

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
