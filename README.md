# Exercism Fortran Track

[![configlet](https://github.com/exercism/fortran/actions/workflows/configlet.yml/badge.svg)](https://github.com/exercism/fortran/actions/workflows/configlet.yml)
[![fortran / main](https://github.com/exercism/fortran/actions/workflows/ci.yml/badge.svg)](https://github.com/exercism/fortran/actions/workflows/ci.yml)
[![Gitpod Ready-to-Code](https://img.shields.io/badge/Gitpod-ready--to--code-blue?logo=gitpod)](https://gitpod.io/#https://github.com/pclausen/fortran)

Exercism exercises in Fortran.

## Setup

Assuming that you have CMake and Fortran running you should be able to run the following commands in a shell:

(in case of Intel Fortran source ifortvars first)

### Linux and MacOS

```bash
mkdir build
cd build
cmake ..
make
ctest -V
```

### Windows

```Batchfile
mkdir build
cd build
cmake -G"NMake Makefiles" ..
nmake
ctest -V
```

For more information see [Installation instructions](docs/INSTALLATION.md)



## Contributing

Thank you so much for contributing! :tada:

Please read about how to [get involved in a track](https://github.com/exercism/docs/tree/master/contributing-to-language-tracks). Be sure to read the Exercism [Code of Conduct](https://exercism.io/code-of-conduct).

We welcome pull requests of all kinds. No contribution is too small.

We encourage contributions that provide fixes and improvements to existing exercises. Please note that this track's exercises must conform to the standards determined in the [exercism/x-common](https://github.com/exercism/x-common) repo. Changes to the tests or documentation of a common exercise will often warrant a PR in that repo before it can be incorporated into this track's exercises. If you're unsure, then go ahead and open a GitHub issue, and we'll discuss the change.

## Exercise Tests ##

At the most basic level, Exercism is all about the tests. They drive the user's implementation forward and tell them when the exercise is complete.

The utmost care and attention should be used when adding or making changes to the tests for an exercise. When implementing an exercise test suite, we want to provide a good user experience for the people writing a solution to the exercise. People should not be confused or overwhelmed.

We simulate Test-Driven Development (TDD) by implementing the tests in order of increasing complexity. We try to ensure that each test either

- helps triangulate a solution to be more generic, or
- requires new functionality incrementally.

### Fortran Track ###

Test files for the Fortran track should be created with the Python3 script `bin/create_fortran_test.py` which is documented [here](docs/MAINTAINERS.md).

## Submitting a Pull Request ##

Please keep the following in mind:

- Pull requests should be focused on a single exercise, issue, or change.

- We welcome changes to code style, and wording. Please open a separate PR for these changes if possible.

- Please open an issue before creating a PR that makes significant (breaking) changes to an existing exercise or makes changes across many exercises. It is best to discuss these changes before doing the work. Discussions related to exercises that are not track specific can be found in [exercism/discussions](https://github.com/exercism/discussions/issues).

- Follow the coding standards for Fortran. (If there is a formatter for the track's language, add instructions for using it here.)

- Watch out for trailing spaces, extra blank lines, and spaces in blank lines.

- All the tests for Fortran exercises can be run from the top level of the repo with ... Please run this command before submitting your PR.

## Contributing a New Exercise ##

- All Exercism exercises must be defined in [x-common](https://github.com/exercism/x-common/tree/master/exercises) before they are implemented for a specific track. Please submit a PR there if your exercise is new to Exercism.

- Please make sure the new exercise conforms to specifications in the [exercism/x-common](https://github.com/exercism/x-common) repo.

- Each exercise must stand on its own. Do not reference files outside the exercise directory. They will not be included when the user fetches the exercise.

- Exercises should use only the Fortran core libraries.

- Please do not add a README or README.md file to the exercise directory. The READMEs are constructed using shared metadata, which lives in the
[exercism/x-common](https://github.com/exercism/x-common) repository. Further explanation can be found in [fixing-exercise-readmes](https://github.com/exercism/docs/blob/master/language-tracks/exercises/anatomy/readmes.md)

- Each exercise should have a test suite, an example solution, a template file for the real implementation and ... (anything else that needs to go with each exercise for this track). The CI build expects files to be named using the following convention: (describe the Fortran convention for naming the various files that make up an exercise).

- Please do not commit any configuration files or directories inside the exercise other than ...

- Be sure to add it to the appropriate place in the `config.json` file. Also, please run `bin/fetch-configlet && bin/configlet` to ensure the exercise is configured correctly.
