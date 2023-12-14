# day 5

almanac
seeds: by numbers

relationships between categories, as lines of 3 numbers
- seed-to-soil
- soil-to-fertilzed
- etc...

mapping
- src/dst/range
- 404 unmapped ones, map to the same number
- 1 to 1

## silver

problem
find the lowest location number
that corresponds to any of the initial seeds

test = 35

## gold

seeds are actually a *range*, determined by PAIR of numbers (start,length)

# day 6

boat race

you travel with your boat in the given times

- get a list of **times** for each **race** in milliseconds
- get a list of best distances for each race in millimetros

you need to go farther than the best distances to win

toy boats, charged by pressing a button while stopped 1ms = 1ml/ms
they go faster the longer it was pressed

can only push the button at the beggining of the race

PROBLEM: multiply(count_of_ways_to_win) = 288

# day 7 Camel Cards

similar to poker

input
- list of hands of 5 cards
- a bid

card strengh
- A, K, Q, J, T, 9, 8, 7, 6, 5, 4, 3, or 2.

hand strength
- five of a kind  (5 equal)
- four of a kind  (4 equal)
- full house      (3 equal and 2 equal)
- three of a kind (3 equal and 2 different random not equal)
- two pair        (2 equal and 2 equal)
- one pair        (2 equal and 3 different random not equal)
- high card       (all different)

ordering
- by hand strength
- by each card on each hand (1 with 1, 2 with 2...)
  - if different hand with the strongest first card is stronger
  - if equal continue


rank = order of the hand, 1 is weakest

goal (total winnings)
- order the hands
- multiply the bid by the rank (starting at 1)
- sum = 6440

## gold

J is a comodin now for hand_strength
but the weakest in card comparisons

goal winnings (same) = 5905

# --- Day 9: Mirage Maintenance ---

- in an _oasis_

- your INPUT
  - list of values (positive/negative)
  - each line is a different value
  - each value on a line is a change of that value

- steps
  1. calculate the difference between all numebrs
  2. if all /= 0
     3. continue using this smaller sequence as the input do (1)
     3. else add a new value to the zeroes and fill the inverse pyramid
        with values equal to the number_below+number_left
        the final numbers is the _prediction_ of that value

- output: the sum of all predicted value
# Day 10
 Gauss's magic shoelace area formula and its calculus companion
 https://www.youtube.com/watch?v=0KjG8Pg6LGk

 Pick's theorem: The wrong, amazing proof
 https://www.youtube.com/watch?v=uh-yRNqLpOg&t=76s

<img src="./day10vis.gold.txt.png" alt="display of only the pipe maze of day 10" width="500"/>

# --- Day 11: Cosmic Expansion ---

sum of lengths of shortests paths between galaxies
- using manhattan distance (no diagonals)
- only count the pairs ONCE

account for universe expansion
  - any row/column that contains no galaxies should be twice as big
  - makes the columns thicked

number the galaxies starting from 1
  - from leftTOright and upTOdown

Example: 9 galaxes, 36 pairs, shortest paths sum = 374

# --- Day 13: Point of Incidence ---
each pattern has 1(one) reflective axis
result = add
- number of cols to the left of vertical reflection
- 100 * number of rows above of horizontal reflectio

<img src="./day13_pid37.gif" alt="search animation for day 13" width="200"/>

# --- Day 14: Parabolic Reflector Dish ---

https://media.githubusercontent.com/media/azimut/challenges/master/assets/day14vispart1.mp4

<video src="https://media.githubusercontent.com/media/azimut/challenges/master/assets/day14vispart1.mp4" width="500" />
