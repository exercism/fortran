# Tests

Each exercise supplies the unit tests and a CMake build recipe.  You
provide the implementation.
Each test file is meant to link against your implementation to provide a
console executable that runs the tests.  Running the test executable
prints messages for each failing test and reports a non-zero exit status
when tests fail.

The test file will have the name `<exercise>_test.f90`, so for exercise
"Bob" the file containing the tests is `bob_test.f90`. Each test will have
a comment describing the test and then the actual test starting with
`call assert_equal` eg.

```
  ! Test 16: non-letters with question
  call assert_equal("Sure.", hey(":) ?"), "non-letters with question")
```

To disable a test, simply comment it out with a `'!'`, eg.

```
  ! Test 16: non-letters with question
  ! call assert_equal("Sure.", hey(":) ?"), "non-letters with question")
```

Working through each exercise is a process of:

* Creating the initial build with CMake
* Repeating these steps until all the tests pass:
  * Fix any compile errors, then run the tests to see which ones fail.
  * Implement just enough to make the next failing test pass.
  * Refactor your implementation to enhance readability, reduce duplication, etc.
  * Run the tests again and move on to the next failing test.


## Creating the Initial Build with CMake

Each exercise will bring a `CMakeLists.txt` file along with the unit
tests.  It contains the canned CMake recipe to handle the build for you.
You should not need to edit this file.  The provided recipe assumes that
your implementation exists in a source file named after
the exercise.

For instance, the exercise "Bob" expects an implementation in the file `bob.f90`.
A stub of this file is provided with the exercise, ready for you to complete.

Using this recipe, CMake can generate a suitable project for your environment
by running `cmake -G` with a suitable generator and the location of the
directory for the exercise.  CMake will generate a build script appropriate
for your operating system.  To keep those generated files separate from
your exercise source code, it is common to create a directory called `build`
to hold these generated build files, as well as the compiled code.

This will keep your exercise folder uncluttered and tidy.

**Note:** The first time `cmake` is called, the [testlib](#testlib) will be downloaded automatically. The `testlib` is needed for the unit tests to work.

Since you will be running CMake to create the build instructions for each
assignment, you might want to create a bash script (Linux/MacOS) or
batch file (Windows) for this command.

Once the build environment has been created by CMake, you can build your
code using the appropriate command for your environment:

* Linux with make: `make`
* Windows with Visual Studio: Select Build / Build Solution from the menu.
* Windows with MingW: `mingw32-make.exe`
* Windows with nMake: `nmake.exe`
* MacOS with Xcode: Select Build from the toolbar

Examples of running CMake for different environments are shown below.

### Linux\MacOS with Make

The generator name for CMake is `Unix Makefiles`.
Assuming the current exercise is `bob` and we're in the exercise folder:

```
$ mkdir build
$ cd build
$ cmake -G "Unix Makefiles" ..
$ make
```

Run `make` in the build directory to compile your solution and the tests.
If there are compile errors, fix them and run `make` again.
When the build succeeds, run the tests:

```
$ ctest -V
```
### Windows with Visual Studio 2017

The generator name for CMake is `Visual Studio 15`.  The same generator
supports all IDE editions of Visual Studio 2017: Community, Professional,
and Enterprise. Assuming the current exercise is `bob` and we're in the
exercise folder:

```
> mkdir build
> cd build
> cmake -G "Visual Studio 15" ..
```

### Windows with MingW

The generator name for CMake is `MinGW Makefiles`. Assuming the current
exercise is `bob` and we're in the exercise folder:

```
> mkdir build
> cd build
> cmake -G "MinGW Makefiles" ..
```

Run `mingw32-make` in the build directory to compile your solution and the tests.
If there are compile errors, fix them and run `mingw32-make` again.
When the build succeeds, run the tests:

```
> ctest -V
```

### MacOS with Xcode

The generator name for CMake is `Xcode`.
Assuming the current exercise is `bob` and we're in the exercise folder:

```
$ mkdir build
$ cd build
$ cmake -G Xcode ..
```
Run `cmake --build .` in the build directory to compile your solution and the tests.
If there are compile errors, fix them and run `cmake --build .` again.
When the build succeeds, run the tests:

```
$ ctest -V
```
### Testlib

The tests depends on a small library called `testlib` which is downloaded from github the first time the build is configured with cmake.

In case the download fails, delete the `testlib` folder if it exists (it may contain empty files), and download the files manually, eg.

```
mkdir testlib
cd testlib
wget https://raw.githubusercontent.com/exercism/fortran/main/testlib/CMakeLists.txt
wget https://raw.githubusercontent.com/exercism/fortran/main/testlib/TesterMain.f90
```


