# Get the exercise name from the current directory
get_filename_component(exercise ${CMAKE_CURRENT_SOURCE_DIR} NAME)

# Basic CMake project
cmake_minimum_required(VERSION 2.8.11)

# Name the project after the exercise
project(${exercise} Fortran)

# set debug build default
set(CMAKE_BIULD_TYPE Debug)

# Get a source filename from the exercise name by replacing -'s with _'s
string(REPLACE "-" "_" file ${exercise})

# Configure to run all the tests?
if(${EXERCISM_RUN_ALL_TESTS})
    add_definitions(-DEXERCISM_RUN_ALL_TESTS)
    set(exercise_f90 ${file}_build_all.f90)
else()
    # if building in exercise folder add testlib
    add_subdirectory(testlib)
    include_directories(testlib ${CMAKE_CURRENT_BINARY_DIR}/testlib)
    if (NOT EXISTS ${CMAKE_CURRENT_SOURCE_DIR}/testlib)
      file(COPY ${CMAKE_CURRENT_SOURCE_DIR}/../../testlib DESTINATION  ${CMAKE_CURRENT_SOURCE_DIR} PATTERN *)
    endif(NOT EXISTS ${CMAKE_CURRENT_SOURCE_DIR}/testlib)
    if(EXISTS ${CMAKE_CURRENT_SOURCE_DIR}/${file}.f90)
        set(exercise_f90 ${file}.f90)
    endif()
endif()


# Build executable from sources and headers
add_executable(${exercise} ${exercise_f90} ${file}_test.f90  )

target_link_libraries(${exercise} TesterMain)

include(CTest)

add_test (${exercise}_test ${exercise} )

# Run the tests on every build
#add_custom_target(test_${exercise} ALL DEPENDS ${exercise} COMMAND ${exercise})

