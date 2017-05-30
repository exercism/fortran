test_suite bob
  character(100) :: multi_line_string

setup
end setup

function random_string(length, begin_char, end_char)
  integer :: length, r, i
  character(length) :: random_string
  logical :: uppercase
  integer :: base, ending
  character :: begin_char, end_char

  base = ichar(begin_char)
  ending = ichar(end_char)

  do i = 1,length
    r = rand(0)*(ending-base)
    random_string(i:i) = char(base + r)
  end do
end function random_string

function random_shouting(length)
  integer :: length
  character(length) :: random_shouting
  random_shouting = random_string(length-1, 'A', 'Z')
  random_shouting(length:length) = '!'
end function random_shouting

function random_question(length)
  integer :: length
  character(length) :: random_question
  random_question = random_string(length-1, 'a', 'z')
  random_question(length:length) = '?'
end function random_question

test stating_something
  assert_equal( 'Whatever.' , hey('Tom-ay-to, tomaaaah-to.') )
  assert_equal( 'Whoa chill out!' , hey('WATCH OUT!') )
  assert_equal( 'Whoa chill out!' , hey(random_shouting(11)) )
  assert_equal( 'Sure.' , hey('Does this cryogenic chamber make me look fat?') )
  assert_equal( 'Sure.' , hey('You are, what, like 15?') )
  assert_equal( 'Sure.' , hey(random_question(11)) )
  assert_equal( 'Whatever.' , hey('Lets''s go make out behind the gym!') )
  assert_equal( 'Whatever.' , hey('It''s OK if you don''t want to go to the DMV.') )
  assert_equal( 'Whoa chill out!' , hey('WHAT THE HELL WHERE YOU THINKING?') )
  assert_equal( 'Whoa chill out!' , hey('1, 2, 3, GO!') )
  assert_equal( 'Whatever.' , hey('1, 2, 3') )
  assert_equal( 'Sure.' , hey('4?') )
  assert_equal( 'Whoa chill out!' , hey('ZOMG THE %^*@#$(*^ ZOMBIES ARE COMING!!11!!1!') )
  assert_equal( 'Whoa chill out!' , hey('I HATE YOU') )
  assert_equal( 'Whatever.' , hey('Ending with ? means a question.') )
  assert_equal( 'Sure.' , hey('Wait! Hang on. Are you going to ge OK?') )
  assert_equal( 'Fine. Be that way!' , hey('') )
  assert_equal( 'Fine. Be that way!' , hey('     ') )

  multi_line_string = ''//NEW_LINE('A')//'Does this cryogenic chamber make me look fat?'//NEW_LINE('A')//'no'
  assert_equal( 'Whatever.' , hey(multi_line_string) )
end test

end test_suite
