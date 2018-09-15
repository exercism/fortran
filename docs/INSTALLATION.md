## Prerequisites

The Fortran language track requires that you have the following software
installed on your system:
* a modern Fortran compiler
* the CMake cross-platform build system

### Prerequisite: A Modern Fortran Compiler 

This language track requires a compiler with [Fortran 2003](https://en.wikipedia.org/wiki/Fortran#Fortran_2003)
support. All major compilers released in the last few years should
be compatible, so as long as you are on a fairly recent version you should be fine.

The following will describe installation of [GNU Fortran](https://gcc.gnu.org/fortran/) or GFortran. Other fortran compilers are listed [here](https://en.wikipedia.org/wiki/List_of_compilers#Fortran_compilers). Intel Fortran is a popular proprietary choice for high performance applications. Most exercises will work with Intel Fortran, but are only tested with GNU Fortran so your milage may vary. 


### Prerequisite: CMake

CMake is an open source cross-platform build system that generates build
scripts for your native build system (`make`, Visual Studio, Xcode, etc.).
Exercism's Fortran track uses CMake to give you a ready-made build that:

* compiles the tests
* compiles your solution
* links the test executable
* automatically runs the tests as part of every build
* fails the build if the any tests fail

Using CMake allows exercism to provide a cross-platform build script that
can generate project files for integrated development environments like
Visual Studio and Xcode.  This allows you to focus on the problem and
not worry about setting up a build for each exercise.

Getting a portable build isn't easy and requires access to many kinds of
systems.  If you encounter any problems with the supplied CMake recipe,
please [report the issue](https://github.com/exercism/cpp/issues) so we can
improve the CMake support.

[CMake 2.8.11 or later](http://www.cmake.org/) is required to use the provided build recipe.


#### Linux

Ubuntu 16.04 and later have compatible compilers in the package manager, so
installing the necessary compiler can be done with `sudo apt-get install gfortran cmake`.

For other distributions, you should be able to acquire the compiler through your
package manager.

#### MacOS

MacOS users can install GCC with [Homebrew](http://brew.sh/) via
`brew install gfortran cmake`.

#### Windows

Windows users can get GNU Fortran through [MingW](http://www.mingw.org/). The easiest way is to first install [chocolatey](https://chocolatey.org).
nd then type in a administrator cmd shell:

`choco install mingw cmake`

This will install MingW (GFortran and GCC) to `C:\tools\mingw64` and CMake to `C:\Program Files\CMake`. You should add the `bin` directories of these installations to your PATH, ie.:

`set PATH=%PATH%;C:\tools\mingw64\bin;C:\Program Files\CMake\bin`

### Prerequisite: CMake

CMake is an open source cross-platform build system that generates build
scripts for your native build system (`make`, Visual Studio, Xcode, etc.).
Exercism's Fortran track uses CMake to give you a ready-made build that:

* compiles the tests
* compiles your solution
* links the test executable
* automatically runs the tests as part of every build
* fails the build if the any tests fail

Using CMake allows exercism to provide a cross-platform build script that
can generate project files for integrated development environments like
Visual Studio and Xcode.  This allows you to focus on the problem and
not worry about setting up a build for each exercise.

Getting a portable build isn't easy and requires access to many kinds of
systems.  If you encounter any problems with the supplied CMake recipe,
please [report the issue](https://github.com/exercism/cpp/issues) so we can
improve the CMake support.

[CMake 2.8.11 or later](http://www.cmake.org/) is required to use the provided build recipe.

