#!/usr/bin/python

import os
import glob
import create_fortran_test



jsons=glob.glob( '../../exercism/problem-specifications/exercises/*/*.json')

for j in jsons:
    exname=os.path.basename(os.path.dirname(j))
    exname_us=exname.replace('-','_')
    expath=os.path.join('new_exercises',exname)
    ex_test_path=os.path.join(expath, exname_us+'_test.f90')
    if os.path.isdir(expath):
        print(f'Found {expath}, not creating this exercise')
    else:
        print(f'Not found {expath}, creating this exercise from {j}')
        os.mkdir(expath)
        try:
            create_fortran_test.create_test(ex_test_path, j)
        except:
            print(f'An exception happened for exercise {expath} from {j}')
            print('Continuing....')
        print(f'Created {expath}')

print('Done')
