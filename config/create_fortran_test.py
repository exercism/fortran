

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
    s="""
    
program EXERCISE_test_main
  use TesterMain
  use EXERCISE
  implicit none

    """

    exercise = j['exercise']
    exercise = exercise.replace('-','_')
    s=s.replace('EXERCISE', exercise )
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


