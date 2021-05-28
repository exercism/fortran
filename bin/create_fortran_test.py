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

$ python3 bin/create_fortran_test.py -j ../problem-specifications/exercises/practice/bob/canonical-data.json -t exercises/practice/bob/bob_test.f90
Namespace(json='../problem-specifications/exercises/practice/bob/canonical-data.json', target='exercises/practice/bob/bob_test.f90')
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
import re 


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
    error = c['expected']['error'] if type(c['expected']) is dict and 'error' in c['expected'] else None
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
    if error:
        expected = 'ERROR'
        si.append('  ! ERROR: %s'%(error))
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
    exercise = j['exercise']
    exercise = exercise.replace('-', '_')
    header = """
! This test was created from %s
!
"""%(os.path.relpath(json_name))

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


def add_meta_and_doc_file(test_name, json_name):
    """
    create 
    
        .meta/tests.toml 
        .meta/config.json
        .docs/instructions.md  (based on ../problem-specifications/exercises/[EXERCISE]/description.md)

    for test_name

    Not yet implemented.
    """
    test_dir_name = os.path.dirname(test_name)
    meta_dir = os.path.join( test_dir_name, '.meta')
    test_toml = os.path.join( meta_dir, 'tests.toml')
    write_tests_toml(json_name, test_toml)

    doc_dir = os.path.join( test_dir_name, '.docs')
    desc_file = os.path.join( os.path.dirname(json_name),  'description.md')
    instruction_file =  os.path.join(doc_dir, 'instructions.md')
    write_instructions(desc_file, instruction_file)
    
    meta_yaml = os.path.join( os.path.dirname(json_name),  'metadata.yml')
    local_config_json = os.path.join(meta_dir, 'config.json')
    write_config_json(test_name, meta_yaml, local_config_json)

    return None

def write_instructions(desc_file, instruction_file):
    lines = open(desc_file).readlines()
    with open(instruction_file, 'w') as of:
        for li in lines:
            of.write(li.replace('# Description','# Instructions'))
    print('wrote %s'%instruction_file)


def write_config_json(test_name, meta_yaml, local_config_json, authors=['pclausen'] ):
    """
    {
  "blurb": "Convert a long phrase to its acronym",
  "authors": [
    "pclausen"
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

    config_dict = get_meta_info(meta_yaml)

    config_dict.update( {
        "authors": authors,
        "files": {
            "solution": [
                "%s.f90"%test_name
            ],
            "test": [
              "%s_test.f90"%test_name
            ],
            "example": [
              ".meta/example.f90"
            ]
        }
    } )

    with open(local_config_json, 'w') as of:
        json.dump(config_dict, of, indent=4)
    print('wrote %s'%local_config_json)


def get_meta_info(meta_yaml):
    lines = open(meta_yaml).readlines()
    lines[0] ="{"
    lines.append("}")
    lines[3] = lines[3].strip() # avoid comma in last line
    lines2 = [re.sub(r'^(\w+):',r'"\1":', li)
        for li in lines ]
    lines3 = [li.replace('\n',',') for li in lines2 ]    
    meta_info = json.loads(''.join(lines3))
    return meta_info    



def write_tests_toml(json_name, test_toml):
    j = None
    with open(json_name) as f:
        j = json.load(f)
    with open(test_toml,'w') as of:
        comment="""# This is an auto-generated file. Regular comments will be removed when this
# file is regenerated. Regenerating will not touch any manually added keys,
# so comments can be added in a "comment" key.

"""
        of.write(comment)
        uuids_descs = get_uuid_and_description(j['cases'])
        for uuid, desc in uuids_descs:
            of.write('[%s]\n'%uuid)
            of.write('description = "%s"\n\n'%desc)
    print('wrote %s'%test_toml)

def get_uuid_and_description(cases):
    uuids_descs = []
    #print(cases)
    for c in cases:
        if 'cases' in c:
            uuids_descs2 = get_uuid_and_description(c['cases'])
            uuids_descs.extend(uuids_descs2)
        #print(c)
        if 'uuid' in c:
            uuids_descs.append( (c['uuid'], c['description']) )
    return uuids_descs


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
    test_dir_name=os.path.dirname(args.target)
    test_dirs = [ test_dir_name,
        os.path.join( test_dir_name, '.meta'),
        os.path.join( test_dir_name, '.docs') ]
    for td in test_dirs:
        if not os.path.isdir(td):
            os.mkdir(td) 
            print('created %s'%td)

    create_test(args.target, args.json)
    add_meta_and_doc_file(args.target, args.json)

