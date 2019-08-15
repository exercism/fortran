#
# Use this script to create and initial <exercise>_test.f90 file 
# which can be used as a skeleton for your test. Typically, you will
# have to replace 'response' in the generated file with the right 
# function call. 
#
# Also note that fortran has issues with special characters such as \n and \t 
# so take special care handling these.
#
# 
# Prerequisites
# - Working cmake and fortran compiler
# - Python3.x (it may work with Python2 but I have not tested)
# - latest version of https://github.com/exercism/problem-specifications.git
#
# Work flow for creating a new test 
# - pull latest changes from exercism/problem-specifications
# - run this script for the example you want to create
# - copy config/CMakeLists.txt for exercise directory
# - implement working exercise
# - fix potential problematic tests (see eg. exercise/bob "Test 20" and "Test 24") 
# - ensure ctest validates without errors
# - open a pull request with your changes 
#
# For bob example:
#
# $ python3 config/create_fortran_test.py -j ../../../exercism/problem-specifications/exercises/bob/canonical-data.json -t exercises/bob/bob_test.f90
# Namespace(json='../../../exercism/problem-specifications/exercises/bob/canonical-data.json', target='exercises/bob/bob_test.f90')
# Wrote : exercises/bob/bob_test.f90
# $ cp config/CMakeLists.txt exercises/bob/.
# $ cd exercises/bob
# $ touch bob.f90
# $ mkdir Debug
# $ cd Debug
# $ cmake ..
# $ make 
# $ ctest -V


import json
import argparse

def fix_and_quote_fortran_multiline(txt):
    if isinstance(txt, str):
        txt=txt.replace('\n', '"// & \n    & "')
        return '"%s"'%txt
    else:
        return txt

def write_testcase(c, tnum):    
    si=[]
        # {'description': 'non-question ending with whitespace', 'property': 'response', 'input': {'heyBob': 'This is a statement ending with whitespace      '}, 'expected': 'Whatever.'}
    description = c['description']
    fcall = c['property']
    args = [v for k,v in c['input'].items()]
    inp = '{}({}'.format( fcall, fix_and_quote_fortran_multiline(args[0]))
    for a in args[1:]:
        inp='{}, {}'.format(inp, fix_and_quote_fortran_multiline(a))
    inp='{})'.format(inp)
    expected = c['expected']        
    expected = fix_and_quote_fortran_multiline(expected) 
    si.append('  ! Test %d: %s'%(tnum+1, description))        
    si.append('  call assert_equal({}, {}, "{}")'.format(expected, inp, description))
    return si


def create_single_test(j):
    si=[]
    for tnum,c in enumerate(j['cases']):
        # {'description': 'non-question ending with whitespace', 'property': 'response', 'input': {'heyBob': 'This is a statement ending with whitespace      '}, 'expected': 'Whatever.'}
        if 'cases' in c:
            si.extend(create_single_test(c))
        else:
            si.extend(write_testcase(c, tnum))
    return si

    

def create_test(test_name, json_name):
    f = open (json_name)
    j=json.load(f)
    f.close()
    header="""
! This test was created from JSON    
! version: EXERCISE_VERSION    
!

"""
    program="""
    
program EXERCISE_test_main
  use TesterMain
  use EXERCISE
  implicit none

    """

    exercise_version = j['version']
    exercise = j['exercise']
    exercise = exercise.replace('-','_')

    s=header.replace('JSON', json_name).replace('EXERCISE_VERSION',exercise_version)    
    s=s+program.replace('EXERCISE', exercise )
    si=s.splitlines()
    si.extend(create_single_test(j))

    si.append(' ')
    si.append('  call test_end()')
    si.append(' ')
    si.append('end program')
    si.append(' ')
    #json.dumps(j)
    of=open(test_name, 'w')
    for ss in si:
        of.write('%s\n'%ss)
    of.close()

if __name__ == '__main__':

    parser = argparse.ArgumentParser(description='Create test.f90')
    
    parser.add_argument("-j", "--json",
              dest='json',
              required=True,
              help="json file with test spec ")
    parser.add_argument("-t", "--target",
              dest='target',
              required=True,
              help="Target file, eg. <exercise>_test.f90 ")
    args = parser.parse_args()

    print (args ) 
    create_test(args.target, args.json)
    
    print ('Wrote : '+args.target)
    


