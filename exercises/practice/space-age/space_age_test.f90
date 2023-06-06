program space_age_test_main
   use TesterMain
   use space_age

   implicit none

   ! Test 0: age on Neptune
   call assert_equal(0.35016863257806585d0, age_in_years("Neptune", 1821023456.d0), "age on Neptune")

   ! Test 1: age on Uranus
   call assert_equal(0.45641439979244397d0, age_in_years("Uranus", 1210123456.d0), "age on Uranus")

   ! Test 2: age on Saturn
   call assert_equal(2.1521752248037473d0, age_in_years("Saturn", 2000000000.d0), "age on Saturn")

   ! Test 3: age on Jupiter
   call assert_equal(2.4091431771337701d0, age_in_years("Jupiter", 901876382.d0), "age on Jupiter")

   ! Test 4: age on Mars
   call assert_equal(35.884187517994398d0, age_in_years("Mars", 2129871239.d0), "age on Mars")

   ! Test 5: age on Venus
   call assert_equal(9.778426831369266d0, age_in_years("Venus", 189839836.d0), "age on Venus")

   ! Test 6: age on Mercury
   call assert_equal(280.87933423985845d0, age_in_years("Mercury", 2134835688.d0), "age on Mercury")

   ! Test 7: age on Earth
   call assert_equal(31.688087814028950d0, age_in_years("Earth", 1000000000.d0), "age on Earth")

   call test_report()

end program

