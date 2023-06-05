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

$ python3 bin/create_fortran_test.py -j ../problem-specifications/exercises/bob/canonical-data.json -t exercises/practice/bob/bob_test.f90
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


def create_stub(exercise, stub_file_name):
    stub_lines = """
module %s
  implicit none
contains

  logical function dummy()
    dummy=.true.
  end function

end module
""" % (exercise)

    with open(stub_file_name, 'w') as f:
        f.write(stub_lines)
    print(f'wrote stub : {stub_file_name}')


def create_test(test_name, json_name):
    """Main function writing header and footer of the Fortran test file"""
    j = None
    with open(json_name) as f:
        j = json.load(f)
    exercise = j['exercise']
    exercise = exercise.replace('-', '_')
    header = """
! This test was created from %s
!
""" % (os.path.relpath(json_name))

    program = """
program %s_test_main
  use TesterMain
  use %s
  implicit none

""" % (exercise, exercise)

    s = header + program
    si = s.splitlines()
    si.extend(create_single_test(j))

    si.append('')
    si.append('  call test_report()')
    si.append('')
    si.append('end program')
    si.append('')
    # json.dumps(j)
    with open(test_name, 'w') as of:
        for ss in si:
            of.write('%s\n' % ss)

    print('Wrote : ' + test_name)
    stub_file_name = os.path.join(os.path.dirname(test_name), exercise+'.f90')
    create_stub(exercise, stub_file_name)


def add_meta_and_doc_file(test_file_name, json_name):
    """
    create 

        .meta/config.json
        .docs/instructions.md  (based on ../problem-specifications/exercises/[EXERCISE]/description.md)

    for test_file_name

    The file .meta/tests.toml will be created with:
        configlet sync

    """
    test_dir_name = os.path.dirname(test_file_name)
    exercise_name = os.path.basename(test_dir_name).replace('-', '_')
    meta_dir = os.path.join(test_dir_name, '.meta')

    doc_dir = os.path.join(test_dir_name, '.docs')
    desc_file = os.path.join(os.path.dirname(json_name),  'description.md')
    instruction_file = os.path.join(doc_dir, 'instructions.md')
    desc_file_lines = open(desc_file, encoding='utf-8').readlines()
    write_instructions(desc_file_lines, instruction_file)

    meta_yaml = os.path.join(os.path.dirname(json_name),  'metadata.yml')
    meta_toml = os.path.join(os.path.dirname(json_name),  'metadata.toml')
    if os.path.exists(meta_toml):
        config_dict = toml.loads(pathlib.Path(meta_toml).read_text())
    elif os.path.exists(meta_yaml):
        config_dict = get_meta_info(meta_yaml)
    else:
        raise ValueError("Unable to find metadata file (yml or toml)")
    local_config_json = os.path.join(meta_dir, 'config.json')
    write_config_json(exercise_name, config_dict, local_config_json)

    return None


def write_instructions(desc_file_lines, instruction_file):
    with open(instruction_file, 'w', encoding='utf-8') as of:
        for li in desc_file_lines:
            of.write(li.replace('# Description', '# Instructions'))
    print('wrote %s' % instruction_file)


def write_config_json(exercise_name, config_dict, local_config_json, authors=['pclausen']):
    """
    {
  "blurb": "Convert a long phrase to its acronym",
  "authors": [
  ],
  "files": {
    "solution": [
      "acronym.f90"
    ],
    "test": [
      "acronym_test.f90"
    ],
    "example": [
      ".meta/example.f90"
    ]
  },
  "source": "Julien Vanier",
  "source_url": "https://github.com/monkbroc"
}
"""

    config_dict.update({
        "authors": authors,
        "files": {
            "solution": [
                "%s.f90" % exercise_name
            ],
            "test": [
                "%s_test.f90" % exercise_name
            ],
            "example": [
                ".meta/example.f90"
            ]
        }
    })

    with open(local_config_json, 'w') as of:
        json.dump(config_dict, of, indent=4)
    print('wrote %s' % local_config_json)


def get_meta_info(meta_yaml):
    lines = open(meta_yaml).readlines()
    lines[0] = "{"
    # avoid comma to replaced with \n in last line
    lines[-1] = lines[-1].strip()
    lines.append("}")
    lines2 = [re.sub(r'^(\w+):', r'"\1":', li)
              for li in lines]
    lines3 = [li.replace('\n', ',') for li in lines2]
    meta_info = json.loads(''.join(lines3))
    return meta_info


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

    # create dirs if not there
    test_dir_name = os.path.dirname(args.target)
    test_dirs = [test_dir_name,
                 os.path.join(test_dir_name, '.meta'),
                 os.path.join(test_dir_name, '.docs')]
    for td in test_dirs:
        if not os.path.isdir(td):
            os.mkdir(td)
            print('created %s' % td)

    create_test(args.target, args.json)
    add_meta_and_doc_file(args.target, args.json)
