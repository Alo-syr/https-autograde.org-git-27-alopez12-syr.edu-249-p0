#lang racket

;;; Project 0 Tic-tac-toe with Racket
;;; 
;;; Please immediately read README.md

(provide board?
         next-player
          valid-move?
          make-move
          winner?
          calculate-next-move)

;; 
;; Useful utility functions
;;

; Returns the number of elements in l for which the predicate f
; evaluates to #t. For example:
;
;    (count (lambda (x) (> x 0)) '(-5 0 1 -3 3 4)) => 3
;    (count (lambda (x) (= x 0)) '(-5 0 1 -3 3 4)) => 1
(define (count f l)
  (cond [(empty? l) 0]
        [(f (car l)) (add1 (count f (cdr l)))]
        [else (count f (cdr l))]))

;; 
;; Your solution begins here
;; 

; Check whether a list is a valid board
(define (board? lst)

  ;checks to see if the length of the list is a square root of a number
  (define lenList (length lst))
  (define sqrtNum (sqrt lenList))
  (define lengthCheck? (integer? sqrtNum))


  ;checks to see if there are only X's E's and O's

  (define (charCheck? lst)
    (define index (car lst))
    (if (member index '(X O E))
        (charCheck? (cdr lst))
        #f))
  
  ;checks for X going first and to make sure that X's and O's differs by at most 1.
  ;(define x-Checks 'X)
  ;(define o-Checks 'O)
  (define xSum (count (lambda (x) (equal? x 'X)) lst))
  (define oSum (count (lambda (x) (equal? x 'O)) lst))
  (define valid-order? (or (= xSum oSum) (= xSum (+ oSum 1))))
  ;(define difference (abs (- xSum oSum)))
  ;(define order? (> oSum xSum))
  ;(define limit? (<= difference 1))

  (and lengthCheck? charCheck? valid-order?))

;;; From the board, calculate who is making a move this turn
(define (next-player board)
  (define xSum (count (lambda (x) (equal? x 'X)) board))
  (define oSum (count (lambda (x) (equal? x 'O)) board))

    (if (<= xSum oSum)
        'X
        'O))

;;; If player ('X or 'O) want to make a move, check whether it's this
;;; player's turn and the position on the board is empty ('E)
(define (valid-move? board row col player)
  
  ; Check if it's the player's turn using functions 3.2
  (define current-player (next-player board))
  (define is-players-turn (equal? current-player player))
  
  (define boardSize (sqrt (length board)))
  
  ; Check if the specified position is within bounds by comparison with edges
  (define inBounds? (and (<= 0 row (- boardSize 1))
                          (<= 0 col (- boardSize 1))))
  
  ; Checks if a position is empty with list-ref 
  (define (emptyCheck? lst row col)
    (equal? (list-ref lst (+ (* row boardSize) col)) 'E))
  
  ; Check if the position is within bounds and empty
  (if (and is-players-turn inBounds?)
      (emptyCheck? board row col)
      #f))

;;; To make a move, replace the position at row col to player ('X or 'O)
;;; We have implemented this for you--you don't have to write it
;;; (just a side note I first saw this and didn't read the comments
;;; I was so scared for a solid 5 minutes lmao)
(define (make-move board row col player)
  (list-set board (+ (* (sqrt (length board)) row) col) player))

;;; To determine whether there is a winner?
(define (winner? board)

  ;Will make checking arrays via divide and conquer possible
  (define boardSize (sqrt (length board)))
  
  ; Checks for row win by indexing through each elem in sub array
  ; and compares first elem to rest of sub array (only for single row)
  (define (checkRow row)
    (if (equal? (car row) (car (cdr row)))
        (if (= (length row) 1)
            (car row) 
            (checkRow (cdr row)))
        #f))
  ; Checks all rows by using checkRow recursively
  (define (checkRows row)
    (if (null? row)
        #f
        (if (checkRows (take (car row) boardSize)) ;disclaimer: I used chatgpt for inspiration here
            (car (car row)) 
            (checkRows (cdr row)))))
  
  (define rowWinner (checkRows board))
  
  ; Checks the top left to bottom right diagonal by indexing through each first char on top left then decreases board size by one
  (define (leftDiagonal board boardSize)
    (if (= boardSize 0)
        '()
        (cons (car (car board)) (leftDiagonal (cdr (map cdr board)) (- boardSize 1)))))
  
  ;Checks the top right to bottom left diagonal the same means, but in reverse which checks top right then decreases
  (define (rightDiagonal board boardSize)
    (if (= boardSize 0)
        '()
        (cons (car (reverse (car board))) (rightDiagonal (cdr (map cdr board)) (- boardSize 1)))))

   ; Check for a win in diagonals (ran out of time :( )
  (define leftdiagonalRow (leftDiagonal board boardSize))
 
   (if rowWinner
      rowWinner
      #F)
  )

;;; OPTIONAL -- extra practice, exploring symbolic AI
;;; Please ping me if you *do* write a solution -- Kris
;;; 
;;; The board is the list containing E O X 
;;; Player will always be 'O
;;; returns a pair of x and y
(define (calculate-next-move board player)
  'todo)

