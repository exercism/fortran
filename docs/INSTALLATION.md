## Prerequisites

The Fortran language track requires that you have the following software
installed on your system:
* a modern Fortran compiler
* the CMake cross-platform build system

### Prerequisite: A Modern Fortran Compiler

This language track requires a compiler with [Fortran 2003](https://en.wikipedia.org/wiki/Fortran#Fortran_2003)
support. All major compilers released in the last few years should
be compatible, so as long as you are on a fairly recent version you should be fine.

The following will describe installation of [GNU Fortran](https://gcc.gnu.org/fortran/) or GFortran. Other fortran compilers are listed [here](https://en.wikipedia.org/wiki/List_of_compilers#Fortran_compilers). Intel Fortran is a popular proprietary choice for high performance applications. Most exercises will work with Intel Fortran, but are only tested with GNU Fortran so your mileage may vary.


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
please [report the issue](https://github.com/exercism/fortran/issues) so we can
improve the CMake support.

[CMake 2.8.11 or later](http://www.cmake.org/) is required to use the provided build recipe.


#### Linux

Ubuntu 16.04 and later have compatible compilers in the package manager, so
installing the necessary compiler can be done with

```bash
sudo apt-get install gfortran cmake
```

For other distributions, you should be able to acquire the compiler through your
package manager.

#### MacOS

MacOS users can install GCC with [Homebrew](http://brew.sh/) via

```bash
brew install gfortran cmake
```

#### Windows

With Windows you have a number of options:
- [Windows Subsystem for Linux (WSL)](##### Windows Subsystem for Linux (WSL))
- [Windows with MingW GNU Fortran](##### Windows with MingW GNU Fortran)
- [Windows with Visual Studio with nMake and Intel Fortran](##### Windows with Visual Studio with nMake and Intel Fortran)

##### Windows Subsystem for Linux (WSL)

If you have Windows 10 and Windows Subsystem for Linux (WSL)[https://en.wikipedia.org/wiki/Windows_Subsystem_for_Linux]. If you have Ubuntu 16.04 or later as subsystem, open an ubuntu Bash shell and follow the [Linux](#### Linux) instructions.

##### Windows with MingW GNU Fortran

Windows users can get GNU Fortran through [MingW](http://www.mingw.org/). The easiest way is to first install [chocolatey](https://chocolatey.org).
nd then type in a administrator cmd shell:

```Batchfile
choco install mingw cmake
```

This will install MingW (GFortran and GCC) to `C:\tools\mingw64` and CMake to `C:\Program Files\CMake`. You should add the `bin` directories of these installations to your PATH, ie.:

```Batchfile
set PATH=%PATH%;C:\tools\mingw64\bin;C:\Program Files\CMake\bin
```

##### Windows with Visual Studio with nMake and Intel Fortran

See [Intel Fortran](### Intel Fortran)

### Intel Fortran

For Intel Fortran you have to first initialize the fortran compiler. On windows with Intel Fortran 2019 and Visual Studio 2017 the command line would be:

```Batchfile
"c:\Program Files (x86)\IntelSWTools\compilers_and_libraries_2019\windows\bin\ifortvars.bat" intel64 vs2017
```

This sources the paths for Intel Fortran and cmake should pick it up correctly. Also, on windows you should specify the cmake generator `NMake` for a command line build, eg.

```Batchfile
mkdir Debug
cd Debug
cmake -G"NMake Makefiles" -DCMAKE_BUILD_TYPE="Debug" ..
nmake
ctest -V
```

The commands above will create a Debug directory (not necessary, but good practice) and build (nmake) the executables and test them (ctest).

For other versions of Intel Fortran you want to search your installation for `ifortvars.bat` on windows and on linux/macOS `ifortvars.sh`. Execute the script in a shell without options and a help will explain which options you have. On linux/macOS the commands would be:

```bash
. /opt/intel/parallel_studio_xe_2016.1.056/compilers_and_libraries_2016/linux/bin/ifortvars.sh intel64
mkdir Debug
cd Debug
cmake -DCMAKE_BUILD_TYPE="Debug" ..
make
ctest -V
```
