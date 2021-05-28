# For maintainers

## Helper script for creating Fortran tests: create\_fortran\_test.py

An easy way to create an exercise test is to use the script
`bin/create\_fortran\_test.py`

Use this script to create an initial <exercise>\_test.f90 file which can be used as a template for your test.
Typically, you will have to replace the 'response'-function in the generated file with the correct function call.

Also note that Fortran has issues with special characters such as `\n` and `\t` so take special care handling these.

### Prerequsites
- Working CMake and Fortran compiler
- Python3.x (You can make it may work with Python2, but I have not made the
effort to make it backwards compatible)
- latest version of https://github.com/exercism/problem-specifications.git
- git


### Work flow for creating a new test
- pull latest changes from `exercism/problem-specifications` eg git clone git@github.com:exercism/problem-specifications.git
- Create a new branch for creating a new exercise, eg git checkout -b exercise-bob
- run this script for the example you want to create
- copy `config/CMakeLists.txt` to exercise directory (You can use `bin/update-cmake-files` for this)
- implement working exercise
- fix potential problematic tests (see eg. exercise/bob "Test 20" and "Test 24")
- ensure `ctest` command validates without errors
- copy your solution to .meta/example.f90 and remove the actual implemetatio from exercise file, eg. bob.f90
- update .docs and .meta directories
    * cp ../problem-specifications/exercises/bob/description.md exercises/practice/bob/.docs/instructions.md
        * replace "# Description" with "# Instructions"
    * fill .meta/tests.toml manually (until an automated way exists)
    * fill .meta/config.json manually (until an automated way exists)
        * Use ../problem-specifications/exercises/bob/metadata.yml 
- open a pull request with your changes

For bob example:

```bash
$ python bin/create_fortran_test.py -j ../problem-specifications/main/exercises/bob/canonical-data.json -t exercises/practice/bob/bob_test.f90
Namespace(json='../problem-specifications/main/exercises/bob/canonical-data.json', target='exercises/practice/bob/bob_test.f90')
Wrote : exercises/practice/bob/bob_test.f90
$ cp config/CMakeLists.txt exercises/practice/bob/.
$ cd exercises/practice/bob
$ touch bob.f90
$ mkdir build
$ cd build
$ cmake ..
$ make
$ ctest -V
```

### Changing `CMakeLists.txt`
When changing the cmake file, update the master copy in `config/` and use `bin/update-cmake-files` to copy it to all exercise directories.

## Solution

When you have a solution, copy that solution into ".meta" directory as "example.f90".

Perhaps you want to leave a skeleton implementation of the function or subroutine that helps the student and leave the file with the exercise name in the exercise directory.
