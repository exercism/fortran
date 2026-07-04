"""

See docs/TEST.md for usage of this script

Use this script to create an initial <exercise>_test.f90 file
which can be used as a skeleton for your test. Typically, you will
have to replace 'response' in the generated file with the right
function call.

Also note that Fortran has issues with special characters such as \n and \t
so take special care handling these.


Prerequisites
- Working cmake and fortran compiler
- Python 3.x (it may work with Python 2.x, but that is untested)
- Up-to-date local version of the https://github.com/exercism/problem-specifications.git repo

Workflow for creating a new test
- pull latest changes from exercism/problem-specifications
- run this script for the example you want to create
- copy config/CMakeLists.txt for exercise directory
- implement working exercise
- fix potential problematic tests (see eg. exercise/bob "Test 20" and "Test 24")
- ensure ctest validates without errors
- open a pull request with your changes

For bob example:

$ python3 bin/update-new-exercise-files.py --exercise_path exercises/practice/bob
$ cp config/CMakeLists.txt exercises/practice/bob/.
$ cd exercises/practice/bob
$ mkdir build
$ cd build
$ cmake ..
$ make
$ ctest -V
"""

import json
import argparse
import os
import pathlib
import re
import tomllib
import platform


def problem_spec_dir() -> pathlib.Path:
    """Detect and return the problem specs."""
    cache_dir = os.getenv("XDG_CACHE_HOME", os.getenv("HOME") + "/.cache")
    specs = pathlib.Path(cache_dir) / "exercism/configlet/problem-specifications"
    if specs.exists():
        return specs
    cur = pathlib.Path(os.getcwd())
    for i in cur.parents:
        if i.name == "problem-specifications":
            return i
    raise LookupError("Could not find problem specs")


class Exercise:
    """Exercise holds exercise data."""

    def __init__(self, exercise_path, canonical_path):
        exercise_path = pathlib.Path(exercise_path)
        if not exercise_path.exists():
            raise ValueError(f"{exercise_path} does not exist")
        if not exercise_path.is_dir():
            raise ValueError(f"{exercise_path} is not a directory")

        slug = exercise_path.name
        self.config = json.loads((exercise_path / ".meta" / "config.json").read_text())

        if canonical_path:
            canonical_path = pathlib.Path(canonical_path)
        else:
            canonical_path = problem_spec_dir() / "exercises" / slug / "canonical-data.json"
        self.canonical_data = json.loads(canonical_path.read_text())

        self.slug = slug
        self.name = slug.replace("-", "_")
        self.path = exercise_path
        self.tests = tomllib.loads((exercise_path / ".meta" / "tests.toml").read_text())

    def write_file(self, filetype, content):
        if len(self.config["files"][filetype]) != 1:
            raise ValueError(f"Expected exactly one {filetype} file; got {self.config["files"][filetype]!r}")
        filepath = self.path / self.config["files"][filetype][0]
        filepath.write_text(content.strip() + "\n")

    def write_stub_file(self, content):
        self.write_file("solution", content)

    def write_example_file(self, content):
        self.write_file("example", content)

    def write_test_file(self, content):
        self.write_file("test", content)

    def flatten_test_cases(self, cases):
        """Recursive flatten test cases, returning individual cases with parent descriptions."""
        for case_or_group in cases:
            if "cases" in case_or_group:
                for groups, child_case in self.flatten_test_cases(case_or_group["cases"]):
                    yield ([case_or_group["description"]] + groups, child_case)
            else:
                yield ([], case_or_group)

    def test_cases(self):
        reimplemented = {
            test["reimplements"]
            for test in self.tests.values()
            if test.get("include", True) and "reimplements" in test
        }
        cases = []
        tests = self.tests
        for groups, case in self.flatten_test_cases(self.canonical_data["cases"]):
            # Filter out test cases with include=false or not listed.
            if case["uuid"] not in tests or case["uuid"] in reimplemented:
                continue
            if not tests[case["uuid"]].get("include", True):
                continue
            # Add parent descriptions.
            case["descriptions"] = groups + [case["description"]]
            cases.append(case)
        return cases


def fix_and_quote_fortran_multiline(txt):
    """Fortran can't handle multiline strings, so adding a continuation character '&' if necessary."""
    if isinstance(txt, str):
        txt = txt.replace("\n", '"// & \n    & "')
        return '"%s"' % txt
    return txt


def write_testcase(c, TEST_NUMBER):
    """Putting the test case together.
    Format:
    ! Test <TEST_NUMBER>: (description of test)
    call assert.... (actual test case)
    """
    si = []
    # example data
    # { "description": "non-question ending with whitespace",
    #   "property": "response",
    #   "input": {"heyBob": "This is a statement ending with whitespace      "},
    #   "expected": "Whatever."}
    description = c["description"]
    fcall = c["property"]
    error = c["expected"]["error"] if type(
        c["expected"]) is dict and "error" in c["expected"] else None
    fargs = [v for v in c["input"].values()]
    if fargs:
        inp = f"{fcall}({fix_and_quote_fortran_multiline(fargs[0])}"
    else:
        inp = f"{fcall}({fix_and_quote_fortran_multiline(" ")}"  # empty array
    for a in fargs[1:]:
        inp = f"{inp}, {fix_and_quote_fortran_multiline(a)}"
    inp = f"{inp})"
    expected = c["expected"]
    if expected == True:
        expected = ".true."
    elif expected == False:
        expected = ".false."
    elif expected == "error":
        expected = ".false."
    else:
        expected = fix_and_quote_fortran_multiline(expected)
    si.append("  ! Test %d: %s" % (TEST_NUMBER, description))
    if error:
        expected = "ERROR"
        si.append("  ! ERROR: %s" % (error))
    si.append(f'  call assert_equal({expected}, {inp}, "{description}")')
    si.append("")
    return si


def create_single_test(test_cases):
    """Walk through the json cases and recursively write the test cases"""
    si = []
    for i, c in enumerate(test_cases, start=1):
        si.extend(write_testcase(c, i))
    return si


def stub_implementation(exercise_name: str) -> str:
    return f"""module {exercise_name}
  implicit none
contains

  logical function dummy()
    dummy=.true.
  end function

end module
"""


def test_implementation(exercise):
    """Main function writing header and footer of the Fortran test file"""
    header = f"! The tests were created from https://github.com/exercism/problem-specifications/blob/main/exercises/{exercise.slug}/canonical-data.json\n"

    program = f"""\
program {exercise.name}_test_main
  use TesterMain
  use {exercise.name}
  implicit none

"""

    s = header + program
    si = s.splitlines()
    si.extend(create_single_test(exercise.test_cases()))

    si.append("  call test_report()")
    si.append("")
    si.append("end program")
    si.append("")

    return "\n".join(si)


if __name__ == "__main__":
    parser = argparse.ArgumentParser(description="Create exercise")
    parser.add_argument("-e", "--exercise_path", help="The path of the exercise")
    # parser.add_argument("exercise_name", help="The name of the exercise")
    # parser.add_argument("stub_file_path", help="The stub file"s path")
    # parser.add_argument("test_file_path", help="The test file"s path")
    # parser.add_argument("example_file_path", help="The example file"s path")
    parser.add_argument("--canonical_data_file_path", help="The canonical data file's path", required=False)

    args = parser.parse_args()
    exercise = Exercise(args.exercise_path, args.canonical_data_file_path)

    exercise.write_stub_file(stub_implementation(exercise.name))
    exercise.write_example_file(stub_implementation(exercise.name))
    exercise.write_test_file(test_implementation(exercise))
