# Basic CMake project
cmake_minimum_required(VERSION 3.0.0)

# Name the project after the exercise
project(testlib_unittest Fortran)

# set debug build default
set(CMAKE_BUILD_TYPE Debug)

# Activate Fortran compiler warnings
if(CMAKE_Fortran_COMPILER_ID MATCHES "Intel") # Intel fortran
  if(WIN32)
    set (CCMAKE_Fortran_FLAG ${CCMAKE_Fortran_FLAGS} "/warn:all")
  else()
    set (CMAKE_Fortran_FLAGS ${CCMAKE_Fortran_FLAGS} "-warn all")
  endif()
endif()
if(CMAKE_Fortran_COMPILER_ID MATCHES "GNU") # GFrotran
  set (CMAKE_Fortran_FLAGS ${CCMAKE_Fortran_FLAGS} "-std=f2008 -W -Wall -Wextra -pedantic -fbacktrace")
endif()


# Build executable from sources and headers
add_executable(testlib_unittest testlib_unittest.f90 )
target_link_libraries(testlib_unittest TesterMain)

include(CTest)

add_test (testlib_unittest testlib_unittest )
set_tests_properties(testlib_unittest PROPERTIES WILL_FAIL true ENVIRONMENT EXERCISM_FORTRAN_JSON=1 )

add_test(testlib_unittest_cmp
  ${CMAKE_COMMAND} -E compare_files --ignore-eol
  results.json
  ${CMAKE_CURRENT_SOURCE_DIR}/results.json)
