! The tests were created from https://github.com/exercism/problem-specifications/blob/main/exercises/space-age/canonical-data.json

program space_age_test_main
   use TesterMain
   use space_age

   implicit none

   ! Test 1: age on Earth
   call assert_equal(31.69, age_in_years("Earth", 1000000000.d0), "age on Earth")

   ! Test 2: age on Mercury
   call assert_equal(280.88, age_in_years("Mercury", 2134835688.d0), "age on Mercury")

   ! Test 3: age on Venus
   call assert_equal(9.78, age_in_years("Venus", 189839836.d0), "age on Venus")

   ! Test 4: age on Mars
   call assert_equal(35.88, age_in_years("Mars", 2129871239.d0), "age on Mars")

   ! Test 5: age on Jupiter
   call assert_equal(2.41, age_in_years("Jupiter", 901876382.d0), "age on Jupiter")

   ! Test 6: age on Saturn
   call assert_equal(2.15, age_in_years("Saturn", 2000000000.d0), "age on Saturn")

   ! Test 7: age on Uranus
   call assert_equal(0.46, age_in_years("Uranus", 1210123456.d0), "age on Uranus")

   ! Test 8: age on Neptune
   call assert_equal(0.35, age_in_years("Neptune", 1821023456.d0), "age on Neptune")

   call test_report()

end program
