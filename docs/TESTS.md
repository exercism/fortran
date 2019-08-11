Each exercise supplies the unit tests and a CMake build recipe.  You
provide the implementation.
Each test file is meant to link against your implementation to provide a
console executable that runs the tests.  Running the test executable
prints messages for each failing test and reports a non-zero exit status
when tests fail.

*Note:* Your code is being tested against the test suite every time you build
your project. If your code does not pass the one or more tests but is valid Fortran
code, it will still be compiled.

Running a test is done with the command ctest and use '-V' to get verbose output:
```
$ ctest -V
```


Working through each exercise is a process of:

* Creating the initial build with CMake
* For each unit test:
 * Satisfy compile errors to make the test fail.
 * Implement just enough to make the test pass.
 * Refactor your implementation to enhance readability, reduce duplication, etc.
 * Uncomment the next test

### Creating the Initial Build with CMake

Each exercise will bring a `CMakeLists.txt` file along with the unit
tests.  It contains the canned CMake recipe to handle the build for you.
You should not need to edit this file.  The provided recipe assumes that
your implementation exists in a source file named after
the exercise.

For instance, the exercise `bob` expects an implementation in `bob.f90`
file.

**Create your initial implementation files before running CMake.**  
If you do not have file `bob.f90` when running
CMake for exercise `bob`, then CMake will generate an error about files
not being found.  **These files can be empty, but they must exist.**

Using this recipe, CMake can generate a suitable project for your environment
by running `cmake -G` with a suitable generator and the location of the
directory for the exercise.  CMake will generate a build script appropriate
for your operating system.  To keep those generated files separate from
your exercise source code, it is common to create a directory called `build`
to hold these generated build files, as well as the compiled code.  This
will keep your exercise folder uncluttered and tidy.

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

#### Linux\MacOS with Make

The generator name for CMake is `Unix Makefiles`.
Assuming the current exercise is `bob` and we're in the exercise folder:

```
$ touch bob.f90
$ mkdir Debug
$ cd Debug
$ cmake -G "Unix Makefiles" ..
$ make
```

This example shows creating empty files for the implementation before
running CMake.

Simply type make in the build directory to compile the tests. This should
generate compile time errors. Once the errors are fixed run `make` again.
When all build errors are fixed run the tests:

```
$ ctest -V
```

#### Windows with Visual Studio 2017

The generator name for CMake is `Visual Studio 15`.  The same generator
supports all IDE editions of Visual Studio 2017: Community, Professional,
and Enterprise. Assuming the current exercise is `bob` and we're in the
exercise folder:

```
> copy nul: bob.f90
> mkdir build
> cd build
> cmake -G "Visual Studio 15" ..
```

This example shows creating empty files for the implementation before
running CMake.


#### Windows with MingW

The generator name for CMake is `MinGW Makefiles`. Assuming the current
exercise is `bob` and we're in the exercise folder:

```
> copy nul: bob.f90
> mkdir build
> cd build
> cmake -G "MinGW Makefiles" ..
```

This example shows creating empty files for the implementation before
running CMake.

Simply type make in the build directory to compile the tests. This should
generate compile time errors. Once the errors are fixed run `make` again.
When all build errors are fixed run the tests:

#### MacOS with Xcode

The generator name for CMake is `Xcode`.
Assuming the current exercise is `bob` and we're in the exercise folder:

```
$ touch bob.f90
$ mkdir build
$ cd build
$ cmake -G Xcode ..
```
This example shows creating empty files for the implementation before
running CMake.

Simply type make in the build directory to compile the tests. This should
generate compile time errors. Once the errors are fixed run `make` again.
When all build errors are fixed run the tests:

```
$ ctest -V
```
