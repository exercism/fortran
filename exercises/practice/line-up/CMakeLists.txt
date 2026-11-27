# Get the exercise name from the current directory
get_filename_component(exercise ${CMAKE_CURRENT_SOURCE_DIR} NAME)

# Basic CMake project
cmake_minimum_required(VERSION 3.10)

# Name the project after the exercise
project(${exercise} Fortran)

# set debug build default
set(CMAKE_BUILD_TYPE Debug)

# Get a source filename from the exercise name by replacing -'s with _'s
string(REPLACE "-" "_" file ${exercise})

# Activate Fortran compiler warnings
if(CMAKE_Fortran_COMPILER_ID MATCHES "Intel") # Intel fortran
  if(WIN32)
    add_compile_options(/warn:all)
  else()
    add_compile_options(-warn all)
  endif()
endif()
if(CMAKE_Fortran_COMPILER_ID MATCHES "GNU") # GFortran
  add_compile_options(-std=f2008 -W -Wall -Wextra -pedantic -fbacktrace)
endif()

# Configure to run all the tests?
if(${EXERCISM_RUN_ALL_TESTS})
    add_definitions(-DEXERCISM_RUN_ALL_TESTS)
    add_executable(${exercise} ${file}_build_all.f90 ${file}_test.f90)
    target_link_libraries(${exercise} TesterMain)
else()
    # if building in exercise folder, compile the test library with the exercise
    add_executable(${exercise} TesterMain.f90 ${file}.f90 ${file}_test.f90)
endif()

include(CTest)

add_test (${exercise}_test ${exercise} )

# Run the tests on every build
#add_custom_target(test_${exercise} ALL DEPENDS ${exercise} COMMAND ${exercise})
