# Tests

Each exercise comes with a set of unit tests and everything needed to build and run them.
You provide the implementation.

## Running the tests

Open a terminal in the exercise folder, and run:

```
make
```

This compiles your solution and the tests, then runs the tests.
Run it again each time you change your solution.

If you have the [Exercism CLI](https://exercism.org/docs/using/solving-exercises/working-locally), you can use this command instead, which also runs `make`:

```
exercism test
```

To remove the files created by the build, run `make clean`.

### Without make

If you don't have `make` (on Windows, for example), you can compile and run the tests directly.
For the exercise "Bob":

```
gfortran TesterMain.f90 bob.f90 bob_test.f90 -o run_tests
```

Then run the tests on Linux or macOS:

```
./run_tests
```

Or on Windows:

```
.\run_tests
```

## Working through an exercise

The files for each exercise are named after it.
For the exercise "Bob":

| File             | Contents                                                          |
| ---------------- | ----------------------------------------------------------------- |
| `bob.f90`        | a stub of the solution, ready for you to complete                 |
| `bob_test.f90`   | the tests                                                         |
| `TesterMain.f90` | the test library                                                  |
| `Makefile`       | instructions for `make`                                           |
| `CMakeLists.txt` | instructions for [CMake](#using-cmake-instead), which is optional |

You only need to edit the solution file.

Working through each exercise is a process of repeating these steps until all the tests pass:

- Fix any compile errors, then run the tests to see which ones fail.
- Implement just enough to make the next failing test pass.
- Refactor your implementation to enhance readability, reduce duplication, etc.
- Run the tests again and move on to the next failing test.

A message is printed for each failing test, followed by a summary.
If any tests fail, `make` ends with an error.

Each test has a comment describing the test and then the actual test, starting with `call assert_equal`, eg.

```
  ! Test 16: non-letters with question
  call assert_equal("Sure.", hey(":) ?"), "non-letters with question")
```

To disable a test, simply comment it out with a `'!'`, eg.

```
  ! Test 16: non-letters with question
  ! call assert_equal("Sure.", hey(":) ?"), "non-letters with question")
```

## Using CMake instead

You don't need CMake, but it may be useful if you work in an IDE such as Visual Studio or Xcode, or use a compiler other than GFortran.

The exercise folder must keep its original name, because CMake uses it to find the source files.
Start in the exercise folder:

```
mkdir build
cd build
cmake ..
cmake --build .
ctest -V
```

After changing your solution, only the last two commands are needed.

**Note:** Always run `cmake` from a separate folder, such as `build`.
Running `cmake .` in the exercise folder replaces the `Makefile` that comes with the exercise.

CMake chooses a suitable generator for your system.
To choose another, use the `-G` option, eg. `cmake -G Xcode ..`.
Run `cmake --help` to list the generators you can use.
With Visual Studio or Xcode, run the tests with `ctest -V -C Debug`.

If your exercise folder doesn't contain a `Makefile`, it was downloaded before these files were added to the exercises.
You can still use CMake.
