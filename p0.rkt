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
  (define x-Checks 'X)
  (define o-Checks 'O)
  (define xSum (count (lambda (x) (equal? x x-Checks)) lst))
  (define oSum (count (lambda (x) (equal? x o-Checks)) lst))

  (define difference (abs (- xSum oSum)))
  (define order? (> xSum oSum))
  (define limit? (<= difference 1))

  (and lengthCheck? charCheck? order? limit?))

;;; From the board, calculate who is making a move this turn
(define (next-player board)
  (define x-Checks 'X)
  (define o-Checks 'O)
  (define xSum (count (lambda (x) (equal? x x-Checks) board))
  (define oSum (count (lambda (x) (equal? x o-Checks) board))
  (if (< xSum oSum)
      'O
      'X))

;;; If player ('X or 'O) want to make a move, check whether it's this
;;; player's turn and the position on the board is empty ('E)
(define (valid-move? board row col player)
  'todo)

;;; To make a move, replace the position at row col to player ('X or 'O)
;;; We have implemented this for you--you don't have to write it
(define (make-move board row col player)
  (list-set board (+ (* (sqrt (length board)) row) col) player))

;;; To determine whether there is a winner?
(define (winner? board)
  'todo)

;;; OPTIONAL -- extra practice, exploring symbolic AI
;;; Please ping me if you *do* write a solution -- Kris
;;; 
;;; The board is the list containing E O X 
;;; Player will always be 'O
;;; returns a pair of x and y
(define (calculate-next-move board player)
  'todo)

