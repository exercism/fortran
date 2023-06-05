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

$ python3 bin/create_fortran_test.py -e bob
Namespace(json='../problem-specifications/exercises/bob/canonical-data.json', target='exercises/practice/bob/bob_test.f90')
Wrote : exercises/practice/bob/bob_test.f90
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
import toml
import platform


def fix_and_quote_fortran_multiline(txt):
    """Fortran can't handle multiline strings, so adding a continuation character '&'
    if necessary"""
    if isinstance(txt, str):
        txt = txt.replace('\n', '"// & \n    & "')
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
    # { 'description': 'non-question ending with whitespace',
    #   'property': 'response',
    #   'input': {'heyBob': 'This is a statement ending with whitespace      '},
    #   'expected': 'Whatever.'}
    description = c['description']
    fcall = c['property']
    error = c['expected']['error'] if type(
        c['expected']) is dict and 'error' in c['expected'] else None
    fargs = [v for v in c['input'].values()]
    if fargs:
        inp = '{}({}'.format(fcall, fix_and_quote_fortran_multiline(fargs[0]))
    else:
        inp = '{}({}'.format(
            fcall, fix_and_quote_fortran_multiline(" "))  # empty array
    for a in fargs[1:]:
        inp = '{}, {}'.format(inp, fix_and_quote_fortran_multiline(a))
    inp = '{})'.format(inp)
    expected = c['expected']
    if expected == True:
        expected = '.true.'
    elif expected == False:
        expected = '.false.'
    elif expected == 'error':
        expected = '.false.'
    else:
        expected = fix_and_quote_fortran_multiline(expected)
    si.append('  ! Test %d: %s' % (TEST_NUMBER, description))
    if error:
        expected = 'ERROR'
        si.append('  ! ERROR: %s' % (error))
    si.append('  call assert_equal({}, {}, "{}")'.format(
        expected, inp, description))
    si.append('')
    return si


def flatten_test_cases(j):
    # unpack nested cases
    if 'cases' in j:
        for i in j['cases']:
            yield from flatten_test_cases(i)
    else:
        yield j


def create_single_test(j):
    """Walk through the json cases and recursively write the test cases"""

    flattened_cases = list(flatten_test_cases(j))

    si = []
    for i, c in enumerate(flattened_cases, start=1):
        si.extend(write_testcase(c, i))
    return si


def stub_implementation(exercise_name):
    stub_lines = """module %s
  implicit none
contains

  logical function dummy()
    dummy=.true.
  end function

end module
""" % (exercise_name)

    return stub_lines


def update_stub_file(exercise_name, file_path):
    with open(file_path, 'w') as f:
        f.write(stub_implementation(exercise_name))


def update_example_file(exercise_name, file_path):
    with open(file_path, 'w') as f:
        f.write(stub_implementation(exercise_name))


def update_test_file(exercise_slug, exercise_name, test_file_path, canonical_data_file_path):
    """Main function writing header and footer of the Fortran test file"""
    header = """! The tests were created from https://github.com/exercism/problem-specifications/blob/main/exercises/%s/canonical-data.json
""" % exercise_slug

    program = """
program %s_test_main
  use TesterMain
  use %s
  implicit none

""" % (exercise_name, exercise_name)

    j = None
    with open(canonical_data_file_path) as f:
        j = json.load(f)

    s = header + program
    si = s.splitlines()
    si.extend(create_single_test(j))

    si.append('  call test_report()')
    si.append('')
    si.append('end program')
    si.append('')
    
    with open(test_file_path, 'w') as of:
        for ss in si:
            of.write('%s\n' % ss)


if __name__ == '__main__':
    parser = argparse.ArgumentParser(description='Create exercise')
    parser.add_argument("exercise_slug", help="The slug of the exercise")
    parser.add_argument("exercise_name", help="The name of the exercise")
    parser.add_argument("stub_file_path", help="The stub file's path")
    parser.add_argument("test_file_path", help="The test file's path")
    parser.add_argument("example_file_path", help="The example file's path")
    parser.add_argument("canonical_data_file_path", help="The canonical data file's path")

    args = parser.parse_args()
   
    update_test_file(args.exercise_slug, args.exercise_name, args.test_file_path, args.canonical_data_file_path)
    update_stub_file(args.exercise_name, args.stub_file_path)
    update_example_file(args.exercise_name, args.example_file_path)