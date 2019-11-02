#!/bin/sh
#
# script to update all exercise CMakeLists.txt files
# run from root of the repository with following command:
# $ sh -x config/update_cmake_for_exercises.sh

for c in $(find exercises -name CMakeLists.txt) ; do
  cp config/CMakeLists.txt $c
done

