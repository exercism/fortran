## What changed in https://github.com/exercism/fortran-test-runner/pull/82

Each run goes through CMake. `cmake .` configures a new project and checks the compiler. `cmake --build .` then runs make, which scans Fortran module dependencies, compiles the testlib, compiles the solution and its tests, and links them. The gfortran compile and link steps take only about a tenth of the build time. The rest goes on CMake's configure step and make's dependency scanning.

`bin/run.sh` now calls gfortran directly. It compiles the solution, then the tests, then links them with the testlib. It uses the options set in the track's `CMakeLists.txt` for a Debug build with GFortran (`-g -std=f2008 -W -Wall -Wextra -pedantic -fbacktrace`). The Dockerfile compiles `TesterMain.f90` once at image build with those options. The runner then runs the test binary directly instead of through `ctest`.

Every exercise in the track uses the shared `CMakeLists.txt` with one solution file and one test file, and none has a `test_files` folder. The direct build only works for exercises laid out like this.

The image no longer needs `cmake` and `make`, so it is about 60 MB smaller. The Dockerfile no longer downloads the two `CMakeLists.txt` files. The README now says how the runner builds solutions.

Students will see one change. When a solution doesn't compile, the message will no longer end with three lines of make output (for example `gmake[2]: *** ... Error 1`). The compiler's own messages are unchanged. The expected results of the two error tests are updated to match. I ran the current image and the new one on all the track's example solutions and on some broken solutions (failing tests, syntax errors in the solution and the tests, a missing function, warnings and `error stop`). Apart from the make lines, every result was identical.

**This has been tested in production, and has reduced the median run from 1.9s to 1.0s.**
