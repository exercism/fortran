# For maintainers

## Generating tests: `bin/generate_tests.py`

Test files are generated from the canonical data in
[exercism/problem-specifications](https://github.com/exercism/problem-specifications)
using a Jinja template stored in each exercise at `.meta/template.j2`.

```bash
bin/generate_tests.py bob            # regenerate one exercise
bin/generate_tests.py                # regenerate every exercise that has a template
bin/generate_tests.py --no-pull bob  # skip `git pull` of problem-specifications
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
- Run `bin/add-exercise bob` (needs `jq` and `curl`). This:
  - fetches configlet and runs `configlet create`, which adds the exercise to `config.json` and syncs its docs, metadata and `tests.toml` from problem-specifications
  - sorts `config.json` with `bin/reorder-exercises`
  - copies `exercises/shared/CMakeLists.txt` into the exercise directory
  - writes a stub solution, a stub `.meta/example.f90` and a starter `.meta/template.j2` (from `exercises/shared/template.j2`)

  It prompts for your GitHub username unless you pass `-a <username>`, and sets difficulty 1 unless you pass `-d <difficulty>`.

- Edit `.meta/template.j2` so each case calls the right function with the right inputs, then generate the tests:

  ```bash
  bin/generate_tests.py bob
  ```

- Write a working solution in `.meta/example.f90`. Replace the student file (e.g. `bob.f90`) with a skeleton of the functions or subroutines the tests call, to help the student get started
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

When changing the cmake file, update the master copy in `exercises/shared/` and use `bin/update-cmake-files` to copy it to all exercise directories.

