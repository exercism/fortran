cmake_minimum_required(VERSION 2.8.11)
project(exercism Fortran)
include(CTest)  

function(travis_fixup dir)
    string(REPLACE "-" "_" file ${dir})
    set(subdir ${CMAKE_CURRENT_SOURCE_DIR}/exercises/${dir})
    if(EXISTS ${subdir}/example.f90)
        file(RENAME ${subdir}/example.f90 ${subdir}/${file}.f90)
    endif()
endfunction()

foreach(exercise
  hello-world
  bob
#    word-count
  hamming
#    anagram
#    food-chain
#    beer-song
#    nucleotide-count
#    rna-transcription
#    phone-number
#    grade-school
#    robot-name
#    leap
#    etl
#    space-age
#    grains
#    gigasecond
#    triangle
#    clock
#    raindrops
    difference-of-squares
#    roman-numerals
#    nth-prime
#    sieve
#    binary
#    sum-of-multiples
#    series
#    prime-factors
#    trinary
#    crypto-square
#    scrabble-score
#    hexadecimal
#    say
#    meetup
#    queen-attack
#    allergies
#    atbash-cipher
#    bracket-push
    pangram
)
    set(exercise_dir exercises/${exercise})
    travis_fixup(${exercise})
    add_subdirectory(${exercise_dir})
    execute_process(
        COMMAND ${CMAKE_COMMAND} -DEXERCISM_RUN_ALL_TESTS:BOOL=1 -G ${CMAKE_GENERATOR} .
        WORKING_DIRECTORY ${exercise_dir})
        
endforeach()

