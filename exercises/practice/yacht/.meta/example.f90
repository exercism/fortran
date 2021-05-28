
module yacht
  implicit none

  ! | Ones | 1 × number of ones | Any combination	| 1 1 1 4 5 scores 3 |
  ! | Twos | 2 × number of twos | Any combination | 2 2 3 4 5 scores 4 |
  ! | Threes | 3 × number of threes | Any combination | 3 3 3 3 3 scores 15 |
  ! | Fours | 4 × number of fours | Any combination | 1 2 3 3 5 scores 0 |
  ! | Fives | 5 × number of fives| Any combination | 5 1 5 2 5 scores 15 |
  ! | Sixes | 6 × number of sixes | Any combination | 2 3 4 5 6 scores 6 |
  ! | Full House | Total of the dice | Three of one number and two of another | 3 3 3 5 5 scores 19 |
  ! | Four of a Kind | Total of the four dice | At least four dice showing the same face | 4 4 4 4 6 scores 16 |
  ! | Little Straight |  30 points | 1-2-3-4-5 | 1 2 3 4 5 scores 30 |
  ! | Big Straight | 30 points | 2-3-4-5-6 | 2 3 4 5 6 scores 30 |
  ! | Choice | Sum of the dice | Any combination | 2 3 3 4 6 scores 18 |
  ! | Yacht | 50 points | All five dice showing the same face | 4 4 4 4 4 scores 50 |

  integer,parameter :: YACHT_TYPES_LEN=12

  enum, bind(C) 
    enumerator :: yacht_types
    enumerator :: ones           
    enumerator :: twos           
    enumerator :: threes         
    enumerator :: fours          
    enumerator :: fives          
    enumerator :: sixes          
    enumerator :: full_house     
    enumerator :: four_of_a_kind 
    enumerator :: little_straight
    enumerator :: big_straight   
    enumerator :: choice         
    enumerator :: yacht_          
  end enum

  character(len=15), dimension(YACHT_TYPES_LEN), parameter :: yacht_types_str = (/ &
   &  "ones           ", &
   &  "twos           ", &
   &  "threes         ", &
   &  "fours          ", &
   &  "fives          ", &
   &  "sixes          ", &
   &  "full house     ", &
   &  "four of a kind ", &
   &  "little straight", &
   &  "big straight   ", &
   &  "choice         ", &
   &  "yacht          " /)
  

contains

  integer function score(dice, yacht_type)
    integer, dimension(5), intent(in) :: dice
    character(len=*), intent(in) :: yacht_type
    
    integer :: yatch_type_in

    score=0

    yatch_type_in = get_yacht_type(yacht_type)
    select case (yatch_type_in)
    case (choice)
      score = sum(dice) 
    case (yacht_) 
      if (is_yacht(dice)) then
        score = 50
      end if
    case (ones, twos, threes, fours, fives, sixes)
      score = score_num(dice,yatch_type_in)
    case (full_house)
      if (is_full_house(dice)) then
        score = sum(dice) 
      endif
    case (four_of_a_kind)
      if (is_four_of_a_kind(dice)) then
        score = score_four_of_a_kind(dice) 
      end if 
    case (little_straight)
      if (is_little_straight(dice))then
        score = 30
      end if
    case (big_straight)
      if (is_big_straight(dice))then
        score = 30
      end if
    case default
      write(*,*) 'ERROR: Unknown type: ',  yacht_type, dice
    end select 
    
  end function


  integer function get_yacht_type(yacht_type)
    character(len=*), intent(in) :: yacht_type
    integer :: i
    get_yacht_type = yacht_types

    do i=1,YACHT_TYPES_LEN
      if ( trim(yacht_type) == trim(yacht_types_str(i))) then
        get_yacht_type = i
      end if
    end do
    if (get_yacht_type == yacht_types) then 
      write(*,*) 'ERROR: Wrong yacht type'
    end if
  end function


  integer function occurences(dice, to_find)
    integer, dimension(5), intent(in) :: dice    
    integer to_find
    integer i
    occurences = 0
    do i=1,5
      if ( dice(i)==to_find ) then
        occurences = occurences +1 
      end if
    enddo        
  end function

  logical function is_yacht(dice)
    integer, dimension(5), intent(in) :: dice    
    is_yacht = occurences(dice, dice(1)) == 5
  end function


  logical function is_four_of_a_kind(dice)
    integer, dimension(5), intent(in) :: dice    
    ! either four same to first dice, or four of the same of second dice, or yacht
    is_four_of_a_kind= occurences(dice, dice(1)) >= 4 .or.  occurences(dice, dice(2)) >= 4 
  end function    

  logical function is_little_straight(dice)
    integer, dimension(5), intent(in) :: dice   
    is_little_straight = occurences(dice, 1) == 1  &
      & .and.  occurences(dice, 2) == 1 &
      & .and.  occurences(dice, 3) == 1 &
      & .and.  occurences(dice, 4) == 1 &
      & .and.  occurences(dice, 5) == 1 
  end function    

  logical function is_big_straight(dice)
    integer, dimension(5), intent(in) :: dice   
    is_big_straight = occurences(dice, 2) == 1  &
      & .and.  occurences(dice, 3) == 1 &
      & .and.  occurences(dice, 4) == 1 &
      & .and.  occurences(dice, 5) == 1 &
      & .and.  occurences(dice, 6) == 1 
  end function    

  integer function score_four_of_a_kind(dice)
    integer, dimension(5), intent(in) :: dice    
    integer i, j
    
    score_four_of_a_kind=0
    do j=1,2
      if ( occurences(dice, dice(j)) >= 4) then
        do i=1,5
          if ( dice(j)==dice(i) ) then
            score_four_of_a_kind=score_four_of_a_kind+dice(i)
          end if
        end do
        ! fix yacht, remove one dice from score
        if (occurences(dice, dice(j)) == 5) then
          score_four_of_a_kind=score_four_of_a_kind-dice(j)
        endif
        return
      end if
    enddo
  end function    



  logical function is_full_house(dice)
    integer, dimension(5), intent(in) :: dice    
    integer i
    integer second
    integer num_first
    integer num_second
    is_full_house = .true.
    second = 0
    ! find second dice
    do i=2,5
      if ( dice(1)/=dice(i) ) then
        second = dice(i)
        exit
      end if
    enddo

    ! count 
    num_first = occurences(dice, dice(1))
    num_second = occurences(dice, second)
    if (num_second==2 .and. num_first==3 &
      &  .or.num_second==3 .and. num_first==2 ) then
        is_full_house = .true.
      else
        is_full_house = .false.
    endif    
  end function


  integer function score_num(dice, num)
    integer, dimension(5), intent(in) :: dice    
    integer, intent(in) :: num    
    integer i
    score_num = 0
    do i=1,5
      if (dice(i)==num)then
        score_num=score_num+dice(i)
      endif
    enddo
  end function

end module
