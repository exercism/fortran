# Prerequisites

The Fortran language track requires that you have the following software installed on your system:

- a modern Fortran compiler
- `make` (recommended)

CMake is optional.

## Prerequisite: A Modern Fortran Compiler

This language track requires a compiler with [Fortran 2003](https://en.wikipedia.org/wiki/Fortran#Fortran_2003) support.
All major compilers released in the last few years should be compatible.

The following will describes installation of [GNU Fortran](https://gcc.gnu.org/fortran/) or GFortran.
Other fortran compilers are listed [here](https://en.wikipedia.org/wiki/List_of_compilers#Fortran_compilers).
[Intel Fortran](https://software.intel.com/en-us/fortran-compilers) is a popular proprietary choice for high performance applications.
Most exercises will work with Intel Fortran, but are only tested with GNU Fortran so your mileage may vary.

## Recommended: make

Each exercise includes a `Makefile`, so that you can build and run the tests with a single command: `make`.
This is also what `exercism test` uses.

If you don't have `make`, you can [compile the tests directly](https://exercism.org/docs/tracks/fortran/tests#h-without-make).

## Optional: CMake

CMake is a cross-platform build system that can generate project files for IDEs like Visual Studio and Xcode.
Each exercise includes a CMake recipe, which you can use instead of `make`.
[CMake 3.10 or later](https://cmake.org/) is required.

If you encounter any problems with the supplied CMake recipe, please [report the issue](https://github.com/exercism/fortran/issues).

## Installation

### Linux

Ubuntu 22.04 and later have compatible compilers in the package manager, so the compiler and `make` can be installed with

```bash
sudo apt-get install gfortran make
```

Add `cmake` if you want to use it.

For other distributions, you should be able to acquire the compiler through your package manager.

### MacOS

MacOS users can install GCC with [Homebrew](http://brew.sh/) via

```bash
brew install gfortran
```

`make` is part of the Xcode command line tools, which Homebrew also needs.
Run `brew install cmake` if you want to use CMake.

### Windows

With Windows there are a number of options:

- [Windows Subsystem for Linux (WSL)](#windows-subsystem-for-linux-wsl)
- [Windows with MingW GNU Fortran](#windows-with-mingw-gnu-fortran)
- [Windows with Visual Studio with NMake and Intel Fortran](#windows-with-visual-studio-with-nmake-and-intel-fortran)

#### Windows Subsystem for Linux (WSL)

Windows 10 introduced the [Windows Subsystem for Linux (WSL)](https://en.wikipedia.org/wiki/Windows_Subsystem_for_Linux).
If you have Ubuntu 22.04 or later as the subsystem, open an Ubuntu Bash shell and follow the [Linux](#linux) instructions.

#### Windows with MingW GNU Fortran

Windows users can get GNU Fortran through [MingW](http://www.mingw.org/).
The easiest way is to first install [chocolatey](https://chocolatey.org) and then open an administrator cmd shell and then run:

```Batchfile
choco install mingw cmake
```

This will install MingW (GFortran and GCC) to `C:\tools\mingw64` and CMake to `C:\Program Files\CMake`.
Then add the `bin` directories of these installations to the PATH, ie.:

```Batchfile
set PATH=%PATH%;C:\tools\mingw64\bin;C:\Program Files\CMake\bin
```

CMake is optional, so you can leave it out of both commands.
With MingW, `make` is usually called `mingw32-make`.
If that doesn't work for you, [compile the tests directly](https://exercism.org/docs/tracks/fortran/tests#h-without-make).

#### Windows with Visual Studio with NMake and Intel Fortran

See [Intel Fortran](#intel-fortran).

### Intel Fortran

For [Intel Fortran](https://software.intel.com/en-us/fortran-compilers) you have to first initialize the fortran compiler.
On windows with Intel Fortran 2019 and Visual Studio 2017 the command line should be:

```Batchfile
"c:\Program Files (x86)\IntelSWTools\compilers_and_libraries_2019\windows\bin\ifortvars.bat" intel64 vs2017
```

This sources the paths for Intel Fortran and cmake should pick it up correctly.
Also, on Windows you should specify the cmake generator `NMake` for a command line build, eg.

```Batchfile
mkdir build
cd build
cmake -G"NMake Makefiles" ..
NMake
ctest -V
```

The commands above will create a `build` directory (not necessary, but good practice) and build (NMake) the executables and test them (ctest).

For other versions of Intel Fortran you want to search your installation for `ifortvars.bat` on windows and on linux/macOS `ifortvars.sh`.
Execute the script in a shell without options and a help will explain which options you have.
On Linux or MacOS the commands would be:

```bash
. /opt/intel/parallel_studio_xe_2016.1.056/compilers_and_libraries_2016/linux/bin/ifortvars.sh intel64
mkdir build
cd build
cmake ..
make
ctest -V
```
