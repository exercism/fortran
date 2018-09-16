# Get the exercise name from the current directory
get_filename_component(exercise ${CMAKE_CURRENT_SOURCE_DIR} NAME)

# Basic CMake project
cmake_minimum_required(VERSION 2.8.11)

# Name the project after the exercise
project(${exercise} Fortran)

# set debug build default
set(CMAKE_BIULD_TYPE Debug)

# Configure to run all the tests?
if(${EXERCISM_RUN_ALL_TESTS})
    add_definitions(-DEXERCISM_RUN_ALL_TESTS)
endif()

# Get a source filename from the exercise name by replacing -'s with _'s
string(REPLACE "-" "_" file ${exercise})

if(EXISTS ${CMAKE_CURRENT_SOURCE_DIR}/${file}.f90)
    set(exercise_f90 ${file}.f90)
else()
    set(exercise_f90 "")
endif()

# Build executable from sources and headers
add_executable(${exercise}.exe ${file}_test.f90 TesterMain.f90 ${exercise_f90} )


# Run the tests on every build


include(CTest)

add_test (${exercise}_test ${exercise}.exe )
