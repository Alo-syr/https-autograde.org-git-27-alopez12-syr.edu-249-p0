# Project 0: Tic-tac-toe in Racket

In this project, you will implement several racket functions to
implement a game of tic-tac-toe in Racket. All of your code will be
written in p0.rkt, please modify only that code. We encourage you to
read the GUI's implementation in gui.rkt if you are interested---it
uses functions from your e0.rkt.

You will implement the following five (or six) functions:

- (board? lst) -- checks whether a list l is a valid board
- (next-move board) -- checks which player moves next
- (valid-move? board row col player) -- checks whether a move is valid
- (make-move board row col player) -- updates a board
- (winner? board) -- checks whether a board has a winner
- (choose-next-move board) -- EXCELLENT ONLY -- implements an AI

Grading is as follows:

- To achieve a score of "minimally satisfactory," you must pass all of
  the public tests.
- To achieve a score of "satisfactory," you must pass all of the
  (non-bonus) public and hidden tests.
- To achieve a score of "excellent," you must additionally pass all of
  the bonus tests.

For a minimally-satisfactory score, you must consider boards of only
3*3. To get a satisfactory (and excellent) score, you must consider
boards of arbitrary N*N size.

## 0. Pre-requirement

This project assumes the following:

* Basic functions on lists: car, cdr, cons, append  
* Control constructs: if, cond
* Logic operation: or, and  
* Recursion

Our solution uses roughly the following functions / forms:
{car, cdr, and, or, equal?, null?, if, cons}  

Some parts within this handout are collapsed, please click to expand them

## 1. Intro
||||
|:-|:-:|-:|
| O| O |X |
| X| X |O |
| O| X |X |

Tic-tac-toe is a paper-and-pencil game for two players, X and O, who
take turns marking the spaces in a 3×3 grid. To find some more info
about Tic-tac-toe, you can look at the
[Wikipedia](https://en.wikipedia.org/wiki/Tic-tac-toe) In this
project, we will have you implement several functions to complete the
implementation of tic-tac-toe.

## 2. Representing boards

Board games are represented as a list of symbols of length n=k*k for
some k. Each row of the board is stored sequentially, so a 3*3 board
would be represented as a list of length 9, where the first three
elements represent the first three columns in the first row of the
board. Each element of a game board is one of three symbols: 'X, 'O,
or 'E (for empty).

For example, a 3*3 size initial game board:

||||
|:-|:-:|-:|
| E| E |E |
| E| E |E |
| E| E |E |

is represented in Racket as the list '(E E E E E E E E E)

If we place a X at the middle of the board:

||||
|:-|:-:|-:|
| E| E |E |
| E| X |E |
| E| E |E |

The board be represented by the list '(E E E E X E E E E)

## 3. Task and Specification

> **_NOTE:_** You only need to modify p0.rkt for this project. The
    file gui.rkt uses the functions in p0.rkt.

### 3.0 (board? lst) -> boolean?

This is a Racket predicate to determine if a board is valid. A board
is valid if and only if:

- Its length is a square of some integer (hint: use integer? and sqrt)
- It contains only the symbols 'X 'O 'E (iterate over each element, my
  solution also uses the built-in function `member`)
- The number of Xs and Os differ by at most 1 (use the `count`
  function in the starter code, count the Xs, count the Os, subtract them)

Our reference solution is an `and` of each of these conditions.

Recall that Racket predicates return either #t or #f.

### 3.1 (next-player lst)

This function accepts a board (satisfying board?) and returns either
'X or 'O based on who should make the next move. Player X makes the
first move.

For example, a board like this

||||
|:-|:-:|-:|
| E| E |E |
| E| X |E |
| E| E |E |

will be represented as '(E E E E X E E E E). Calling `(next-player '(E
E E E X E E E E))` should return 'O.

Hint: count the number of Xs--if that number is greater than the
number of Os, then it's O's turn, otherwise it's X's turn.

### 3.2 (valid-move? lst row col player) -> boolean?
lst is a list?  
row, col are both number?  
player is either 'X or 'O
returns a boolean?

This function takes in a board, and returns whether it is valid for
player it the player want to make a move at (row, col), determine
whether it's valid.  A move is valid when:

- It is player's turn to move
- The specified position (row,col) is currently empty (holds 'E)
- Consider that row,col may fall outside the grid (this should return
  #f, but will cause list-ref to crash if you are not careful)

To solve this one: figure out how to use list-ref based on row and
col, you need to do a small calculation to figure this out (e.g.,
using sqrt on the size of the list).

> **_HINT:_** In order to pass hidden tests, you need to consider the
    case when the game board is some arbitrary N*N size.

### 3.3 (winner? board) -> {'X, 'O, #f}
board: board?
returns either 'X, 'O, or #f

This is the hardest function by far, and requires the most open-ended
amount of programming--hence why this function has the bulk of the
tests.

This checks whether a board has a winner and (if so) returns either 'X
or 'O as appropriate. A board has a winner when it has a row full of
'X, column full of 'X, or whose main diagonal is 'X, and mutatis
mutandi for 'O.

For example:

||||
|:-|:-:|-:|
| O| E |E |
| E| X |E |
| E| E |E |

Should return #f as there is no winner yet. But:

||||
|:-|:-:|-:|
| O| X |O |
| E| X |E |
| E| X |E |

will return 'X as the player 'X has a col with 3 connected marks.

The following:

|||||
|:-|:-:|-:|-:|
| O| E |X | E|
| E| X |O | E|
| X| X |E | E|
| E| E |E | E|

Returns #f: even though there's a length-three diagonal (of X), it
would have to be the longest diagonal.

This function is nontrivial--think about how you can collect all the
rows, all the columns, and the two diagonals, each as a list. Then
think about how you could check to see if any of those lists contains
all 'X or all 'O. Assume that there will be only a single winner.

### 3.4 (calculate-next-move board player) -> (cons x y)
board: board?
player is either 'X or 'O
returns a cons cell of x and y.

This part is optional, ungraded (this semester), and will explore
traditional symbolic AI. Tic-tac-toe has a precise brute-force
solution: you can *always* not-lose if you play correctly. In this
part of the project, you will implement a computer AI to beat your
opponent at tic-tac-toe.

To implement your AI, you should use the [MiniMax
algorithm](https://en.wikipedia.org/wiki/Minimax). MiniMax, in
general, says this:

- Every player should choose the move that will maximally bound the
  worst-case thing that could happen to them.

For tic-tac-toe, this means that we think carefully and consider all
different possible moves we might make, and then possible responses to
those moves, and so on. You should then choose the move (which, for
tic-tac-toe, will always exist if you play this strategy from the
start) that makes it impossible for the other player to win. In other
words, you are *maximizing* your action under the (pessimistic)
assumption that the other player will *minimize* your winnings (by
maximizing their own!).

We discuss some examples in the video.

There is no additional credit for this part of the project, but if you
do it I will be impressed. If several students want to do it and
compete against each other, I can organize an in-class contest for
extra credit--but I am not sure if we will have time, we will see :-)

## 4. Play the Game

Once you have implemented these functions correctly, you can play the
game.  Open a terminal in the proper directory and run:

```
racket gui.rkt <args>
```
where args are:

* -v: verbose mode, it will print the board as list after each move, helpful when you want to debug
* -a: AI mode, you will play as 'X first, then an AI will play with you as player 'O
* -k size: specify the size of the board, default is set to 3

For example, if you want to play with AI, simply run:
```
racket gui.rkt -a
```

or enable verbose output on a 4*4 size board
```
racket gui.rkt -v -k 4
```

or simply play within a 3*3 table
```
racket gui.rkt
```
