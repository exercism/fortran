

import json


def fix_fortran_multiline(txt):
    return txt.replace('\n', '"// & \n    & "')

def create_test(test_name, json_name):
    f = open (json_name)
    j=json.load(f)
    f.close()
    s="""
    
program EXERCISE_test_main
  use TesterMain
  use EXERCISE_test
  use EXERCISE
  implicit none

    """

    exercise = j['exercise']
    s=s.replace('EXERCISE', exercise )
    si=s.splitlines()
    for tnum,c in enumerate(j['cases']):
        # {'description': 'non-question ending with whitespace', 'property': 'response', 'input': {'heyBob': 'This is a statement ending with whitespace      '}, 'expected': 'Whatever.'}
        description = c['description']
        fcall = list(c['input'].keys())[0]
        inp = '{}("{}")'.format( fcall, c['input'][fcall] )
        expected = c['expected']
        
        inp = fix_fortran_multiline(inp)
        expected = fix_fortran_multiline(expected)
        si.append('  ! Test %d: %s'%(tnum+1, description))
        si.append('  call assert_equal("{}", {}, "{}")'.format(expected, inp, description))
    
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
    create_test('bob_test.f90', "bob.json")


