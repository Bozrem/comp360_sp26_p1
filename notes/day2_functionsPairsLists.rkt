#lang racket
; Day 2
; Functions, Pairs, and Lists
;;; Daiily DrRacket Protip: Ctrl+Alt/Cmd+; commments; Ctrl+Alt/Cmd+= uncomments

(define course "programming languages") ; this BINDS the string to the name class
(< (+ 4 5) (- 4 5))

;;; Functions
(define (abs x)
  (if (< x 0)
      (- x)
      x))

; Custom Power Function: only correct for y >= 0
; Recursion!
(define (pow x y)
  (if (= y 0)
      1
      (* x (pow x (- y 1)))))

; Custom Cube Function
(define (cube x)
  (pow x 3))
(define sixtyfour (cube 4))

;;; Pairs
(define my-first-racket-pair (cons 4 5))
(car my-first-racket-pair) ; car is first
(cdr my-first-racket-pair) ; cdr is second

; Custom Pair-Swapping Function
(define (swap-pair pair)
  (cons (cdr pair) (car pair)))

; Custom Pair-Summing Function

; Custom Division Function
; Divide first by second, evaluate to the (quotient remainder) as a pair
(define (divide-pair pair)
  (cons (quotient (car pair) (cdr pair))
        (remainder (car pair) (cdr pair))))

; returning more than one value is a pain in Java
; but it's trivial in Racket!
; Free Lesson: if something feels hard the way you're doing it, do it differently!

; Custom Pair-Sorting Function


;;; Lists
'(1 2 3 4 5)
(list 1 2 3 4 5)
; can lists be made from cons?
(cons 2 (cons 1 '()))
(define my-nums '(1 2))
(car my-nums)
(car (cdr my-nums))

; add up all elements of a list
(define (sum-list lst)
  (if (null? lst)
      0
      (+ (car lst) (sum-list (cdr lst)))))
;;; Lists of Pairs

; the next four functions assume that 
; the argument lst is a list of pairs of numbers
(define lst3 (list (cons 4 5) (cons 11 12) (cons 4 5) (cons 7 8)))
lst3

; Recursion! As essential Racket tool!
; Sum Up All Pairs

; Strip Off the First of Each Pair

; Strip Off the Second of Each Pair

; Another Way to Add All Pairs, Using firsts and seconds

