# For maintainers

## Generating tests: `bin/generate_tests`

Test files are generated from the canonical data in
[exercism/problem-specifications](https://github.com/exercism/problem-specifications)
using a Jinja template stored in each exercise at `.meta/template.j2`.

```bash
bin/generate_tests bob            # regenerate one exercise
bin/generate_tests                # regenerate every exercise that has a template
bin/generate_tests --no-pull bob  # skip `git pull` of problem-specifications
```

The script reads problem-specifications from configlet's cache
(`~/.cache/exercism/configlet/problem-specifications`, filled by `bin/configlet sync`),
or from a parent directory named `problem-specifications`.
Only cases included in `.meta/tests.toml` are generated.

Fortran string literals cannot contain escapes such as `\n` and `\t`.
The `escape_quote_whitespace` template filter rewrites these as
`" // NEWLINE // "`, `" // TAB // "` and `" // CARRIAGE_RETURN // "`,
so the template must declare those constants (see `exercises/practice/bob/.meta/template.j2`).

### Prerequisites

- Working CMake and Fortran compiler
- Python 3.12+ with `jinja2`
- git

### Workflow for adding a new exercise

Using `bob` as an example:

- Create a new branch, e.g. `git checkout -b exercise-bob`
- run `bin/add-exercise bob` to fix `config.json`, configlet sync, CMake and starter-file steps below in one go (needs `jq` and `curl`).
- Edit `.meta/template.j2` so each case calls the right function with the right inputs, then generate the tests:

  ```bash
  bin/generate_tests bob
  ```

- Write a working solution in `.meta/example.f90`, and leave a skeleton in the student file (e.g. `bob.f90`)
- Make sure all tests pass, running the full build from the repository root:

  ```bash
  mkdir -p build && cd build
  cmake ..
  cmake --build .
  ctest -V -R bob
  ```

- Run `bin/reorder-exercises` and `bin/configlet lint`
- If everything passes, open a pull request with your changes

### Changing `CMakeLists.txt`

When changing the cmake file, update the master copy in `config/` and use `bin/update-cmake-files` to copy it to all exercise directories.

## Solution

When you have a solution, copy that solution into `.meta/example.f90`.

You should leave a skeleton implementation of the function or subroutine that helps the student and leave the file with the exercise name in the exercise directory.
