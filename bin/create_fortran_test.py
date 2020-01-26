"""

See docs/TEST.md for usage of this script

Use this script to create an initial <exercise>_test.f90 file
which can be used as a skeleton for your test. Typically, you will
have to replace 'response' in the generated file with the right
function call.

Also note that Fortran has issues with special characters such as \n and \t
so take special care handling these.


Prerequsites
- Working cmake and fortran compiler
- Python3.x (it may work with Python2 but I have not tested)
- latest version of https://github.com/exercism/problem-specifications.git

Work flow for creating a new test
- pull latest changes from exercism/problem-specifications
- run this script for the example you want to create
- copy config/CMakeLists.txt for exercise directory
- implement working exercise
- fix potential problematic tests (see eg. exercise/bob "Test 20" and "Test 24")
- ensure ctest validates without errors
- open a pull request with your changes

For bob example:

$ python3 bin/create_fortran_test.py -j ../../../exercism/problem-specifications/exercises/bob/canonical-data.json -t exercises/bob/bob_test.f90
Namespace(json='../../../exercism/problem-specifications/exercises/bob/canonical-data.json', target='exercises/bob/bob_test.f90')
Wrote : exercises/bob/bob_test.f90
$ cp config/CMakeLists.txt exercises/bob/.
$ cd exercises/bob
$ touch bob.f90
$ mkdir build
$ cd build
$ cmake ..
$ make
$ ctest -V
"""

import json
import argparse
import os

def fix_and_quote_fortran_multiline(txt):
    """Fortran can't handle multiple, so adding continuation character '&'
    if necessary"""
    if isinstance(txt, str):
        txt = txt.replace('\n', '"// & \n    & "')
        return '"%s"'%txt
    return txt

def write_testcase(c, tnum):
    """Putting the test case together.
    Format:
    ! Test <tnum>: (description of test)
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
    fargs = [v for v in c['input'].values()]
    inp = '{}({}'.format(fcall, fix_and_quote_fortran_multiline(fargs[0]))
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
    si.append('  ! Test %d: %s'%(tnum+1, description))
    si.append('  call assert_equal({}, {}, "{}")'.format(expected, inp, description))
    return si


def create_single_test(j):
    """Walk through the json cases and recursively write the test cases"""
    si = []
    for tnum, c in enumerate(j['cases']):
        if 'cases' in c:
            si.extend(create_single_test(c))
        else:
            si.extend(write_testcase(c, tnum))
    return si


def create_stub(exercise, stub_file_name):
    stub_lines = """
module %s
  implicit none
contains

  logical function dummy()
    dummy=.true.
  end function

end module
"""%(exercise)

    with open(stub_file_name, 'w') as f:
        f.write(stub_lines)
    print(f'wrote stub : {stub_file_name}')


def create_test(test_name, json_name):
    """Main function writing header and footer of the Fortran test file"""
    j = None
    with open(json_name) as f:
        j = json.load(f)
    exercise_version = j['version']
    exercise = j['exercise']
    exercise = exercise.replace('-', '_')
    header = """
! This test was created from %s
! version: %s
!
"""%(json_name, exercise_version)

    program = """
program %s_test_main
  use TesterMain
  use %s
  implicit none

"""%(exercise, exercise)

    s = header + program
    si = s.splitlines()
    si.extend(create_single_test(j))

    si.append('')
    si.append('  call test_report()')
    si.append('')
    si.append('end program')
    si.append('')
    #json.dumps(j)
    with open(test_name, 'w') as of:
        for ss in si:
            of.write('%s\n'%ss)

    print('Wrote : ' + test_name)
    stub_file_name=os.path.join(os.path.dirname(test_name), exercise+'.f90')
    create_stub(exercise, stub_file_name)

if __name__ == '__main__':

    parser = argparse.ArgumentParser(description='Create test.f90')

    parser.add_argument("-j", "--json",
                        dest='json',
                        required=True,
                        help="json file with test spec")
    parser.add_argument("-t", "--target",
                        dest='target',
                        required=True,
                        help="Target file, eg. <exercise>_test.f90")
    args = parser.parse_args()

    print(args)

    create_test(args.target, args.json)


