cmake_minimum_required(VERSION 2.8.11)
project(exercism Fortran)
include(CTest)

set(EXERCISM_RUN_ALL_TESTS 1)

function(travis_fixup exercise)
  string(REPLACE "-" "_" file ${exercise})
  set(subdir ${CMAKE_CURRENT_SOURCE_DIR}/exercises/${exercise})
  if(EXISTS ${subdir}/example.f90)
    configure_file( ${subdir}/example.f90 ${subdir}/${file}_build_all.f90)
  endif()
endfunction()

add_subdirectory(testlib)
include_directories(testlib ${CMAKE_CURRENT_BINARY_DIR}/testlib)

file(GLOB exercise_list ${CMAKE_CURRENT_SOURCE_DIR}/exercises/*/CMakeLists.txt)

foreach(exercise_cmake ${exercise_list})
  get_filename_component(exercise_dir ${exercise_cmake} DIRECTORY)
  get_filename_component(exercise ${exercise_dir} NAME)
  travis_fixup(${exercise})
  add_subdirectory(${exercise_dir})
endforeach()



