#lang racket
; Day 1
; Welcome to Racket!

; Racket evaluates each line of code, top to bottom
"hello world"

; add x = 3 to the current environment
(define x 3)
x

; adds y = 7 to the current environment
(define y 7)
y

; to evaluate an addition, evaluate the subexpressions and add 
(+ 4 7 7 7)
(+ (+ 4 3) (+ 2 6))

; to evaluate a variable, lookup its value in the environment  
(+ x y)

; evaluates (- x y), which results in -4, then
; adds z = -4 to the current environment
(define z (- x y))
z

; evaluates the whole math expression: q = (x + 2) * (z - 3), 
; which results in -35
; adds q = -35 to the current environment
(define q (* (+ x 2) (- z 3)))
q

; let's introduce control flow to compute absolute values

; let's display the results of what we've done

; now let's try to break things a little bit!
; (+ "hello" 4)