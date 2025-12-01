cmake_minimum_required(VERSION 3.5.0)
project(exercism Fortran)
include(CTest)

set(EXERCISM_RUN_ALL_TESTS 1)

# Activate Fortran compiler warnings
if(CMAKE_Fortran_COMPILER_ID MATCHES "Intel") # Intel fortran
  if(WIN32)
    set (CMAKE_Fortran_FLAGS "/warn:all")
  else()
    set (CMAKE_Fortran_FLAGS "-warn all")
  endif()
endif()
if(CMAKE_Fortran_COMPILER_ID MATCHES "GNU") # GFortran
  set (CMAKE_Fortran_FLAGS "-std=f2008 -W -Wall -Wextra -pedantic -fbacktrace")
endif()

set(practicedir ${CMAKE_CURRENT_SOURCE_DIR}/exercises/practice)


function(travis_fixup exercise)
  string(REPLACE "-" "_" file ${exercise})
  set(subdir ${practicedir}/${exercise})
  if(EXISTS ${subdir}/.meta/example.f90)
    configure_file( ${subdir}/.meta/example.f90 ${subdir}/${file}_build_all.f90)
  endif()
endfunction()

add_subdirectory(testlib)
include_directories(testlib ${CMAKE_CURRENT_BINARY_DIR}/testlib)

file(GLOB exercise_list ${practicedir}/*/CMakeLists.txt)

foreach(exercise_cmake ${exercise_list})
  get_filename_component(exercise_dir ${exercise_cmake} DIRECTORY)
  get_filename_component(exercise ${exercise_dir} NAME)
  travis_fixup(${exercise})
  add_subdirectory(${exercise_dir})
endforeach()



