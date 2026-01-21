#lang racket
;;; COMP 360 - Day 3 Practice Problems
;;; Syntax, Semantics, Types, Side Effects, cond, cons, and Recursion

;;; ============================================================
;;; PROBLEM 1: Syntax vs. Semantics
;;; ============================================================

;;; Part A: Give ONE example of a Racket expression that has BAD SYNTAX
;;; (i.e., the code will not parse/run due to a syntax error).
;;; Write your example as a comment.

; Your bad syntax example here:
; 4 + 3

;;; Part B: Give TWO examples of Racket programs that are SYNTACTICALLY
;;; SIMILAR (same structure/form) but have DIFFERENT SEMANTICS (they
;;; compute different things or behave differently).
;;;
;;; For example, consider how small changes to operators or values
;;; can make code that looks nearly identical behave very differently.
;;;
;;; Write both examples below and briefly explain how their semantics differ.

; Example 1:
(+ 4 5)

; Example 2:
(eq? 4 5)

; Explanation of how the semantics differ:
; same exact syntax: (a b c), very different semantics


;;; ============================================================
;;; PROBLEM 2: Rewriting with cond
;;; ============================================================
;;; The following function is from Day 2 practice. It uses nested if
;;; expressions. Rewrite it using a single cond expression instead.
;;;
;;; Original (using nested ifs):
;;; (define (contains? a lst)
;;;   (if (null? lst)
;;;       #f
;;;       (if (eq? (car lst) a)
;;;           #t
;;;           (contains? a (cdr lst)))))
;;;
;;; Hint: Your cond should have three clauses:
;;;   1. Check if the list is empty
;;;   2. Check if the first element matches
;;;   3. Otherwise, recurse on the rest of the list

; Your code here:
(define (contains? a lst)
  (cond ((null? lst) #f)
        ((eq? (car lst) a) #t)
        (#t (contains? a (cdr lst)))))

; Test cases:
"contains? test"
(contains? 3 '(1 2 3 4))   ; should be #t
(contains? 5 '(1 2 3 4))   ; should be #f
(contains? 'a '())         ; should be #f


;;; ============================================================
;;; PROBLEM 3: Types and Type-Checking
;;; ============================================================
;;; Racket is dynamically typed, meaning type errors are caught at
;;; runtime, not compile-time. Racket provides type predicates like
;;; number?, string?, list?, pair?, and boolean? to check types manually.

;;; Part A: For each expression below, predict whether it will:
;;;   - Return a value (and what value)
;;;   - Cause a runtime type error
;;; Then test your predictions in DrRacket.

; (+ 5 "hello")
; Prediction: runtime error - invalid contract

; (string-append "hello" "world")
; Prediction: "helloworld"

; (car '())
; Prediction: runtime error - invalid contract

; (cons 1 2)
; Prediction: '(1 . 2)


;;; Part B: Write a function called `safe-car` that takes any value.
;;; If the value is a non-empty list OR a pair, return its car.
;;; Otherwise, return the symbol 'error.
;;;
;;; You MUST use type-checking predicates (pair?, null?, etc.)
;;;
;;; Examples:
;;;   (safe-car '(1 2 3))    => 1
;;;   (safe-car (cons 4 5))  => 4
;;;   (safe-car '())         => 'error
;;;   (safe-car 42)          => 'error
;;;   (safe-car "hello")     => 'error
;;;
;;; Hints:
;;;   - (pair? x) returns #t if x is a cons cell (pair or non-empty list)
;;;   - An empty list is NOT a pair: (pair? '()) => #f

; Your code here:
(define (safe-car a)
  (cond ((null? a) 'error)
        ((pair? a) (car a))
        ((list? a) (car a))
        (#t 'error)))

; Test cases:
"safe-car test"
(safe-car '(1 2 3)) ; 1
(safe-car (cons 4 5)) ; 4
(safe-car '()) ; #f
(safe-car 42) ; #f
(safe-car "hello") ; #f


;;; ============================================================
;;; PROBLEM 4: Side Effects
;;; ============================================================
;;; A side effect is when a function modifies state or interacts with
;;; the outside world (e.g., printing to the screen). In pure functional
;;; programming, functions avoid side effects - they only compute and
;;; return values.

;;; Part A: Consider the following two functions. One has a side effect,
;;; one does not. Identify which one has a side effect and explain why.

(define (mystery1 x)
  (+ x 1))

(define (mystery2 x)
  (displayln x)
  (+ x 1))

; Which function has a side effect?
; Why is it considered a side effect?
; mystery2 has a side-effect: printing to the screen
(mystery1 10)
(mystery2 10)

;;; Part B: Write a function called `sum-list-debug` that computes the
;;; sum of a list of numbers, BUT also prints each element as it
;;; processes them (for debugging purposes).
;;;
;;; Use (displayln x) to print x followed by a newline.
;;;
;;; Example:
;;;   (sum-list-debug '(1 2 3))
;;;   ; prints: 1
;;;   ; prints: 2
;;;   ; prints: 3
;;;   ; returns: 6
;;;
;;; Hint: The displayln call should come BEFORE the main computation
;;; in each recursive call.

; Your code here:
(define (sum-list-debug a)
  (cond ((null? a) 0)
        (#t 
         (displayln (car a))
         (+ (car a) (sum-list-debug (cdr a))))))

; Test cases:
"sum-list-debug test"
(sum-list-debug '(1 2 3))
(sum-list-debug '(10 20 30 40))


;;; ============================================================
;;; PROBLEM 5: Recursion with cond
;;; ============================================================
;;; Write a function called `count-types` that takes a list containing
;;; mixed types and returns a pair where:
;;;   - The car is the count of numbers in the list
;;;   - The cdr is the count of strings in the list
;;;
;;; Use recursion, cond, and type predicates (number?, string?).
;;; Use cons to build the result pair.
;;;
;;; Examples:
;;;   (count-types '(1 "hi" 2 "bye" 3))  => '(3 . 2)
;;;   (count-types '(1 2 3 4 5))         => '(5 . 0)
;;;   (count-types '("a" "b" "c"))       => '(0 . 3)
;;;   (count-types '(x y z))             => '(0 . 0)
;;;   (count-types '(x "a" z 1 4 5 "z")) => '(3 . 2)
;;;   (count-types '())                  => '(0 . 0)
;;;
;;; Hints:
;;;   - Base case: empty list returns (cons 0 0)
;;;   - Can you write an expression that gives the number of numbers in the REST of the list?
;;;   - Can you write an expression that gives the number of strings in the REST of the list?
;;;   - If the first element is a number, what's the resulting (cons n s) look like?
;;;   - If the first element is a string, what's the resulting (cons n s) look like?
;;;   - What if the first element is neither?

; Your code here:
(define (count-types a)
  (cond ((null? a) (cons 0 0))
        ((number? (car a)) (cons (+ 1 (car (count-types (cdr a)))) (cdr (count-types (cdr a)))))
        ((string? (car a)) (cons (car (count-types (cdr a))) (+ 1 (cdr (count-types (cdr a))))))
        (#t (cons (car (count-types (cdr a))) (cdr (count-types (cdr a)))))))

;        (car (count-types (cdr a))) ; this is the number of numbers in the rest of the list
;        (cdr (count-types (cdr a))) ; this is the number of strings in the rest

; Test cases:
"count-types test"
(count-types '(1 "hi" 2 "bye" 3))
(count-types '(1 2 3 4 5))
(count-types '("a" "b" "c"))
(count-types '(x "a" z 1 4 5 "z"))
(count-types '(x y z))
(count-types '())


;;; ============================================================
;;; PROBLEM 6: Recursion with Type-Checking
;;; ============================================================
;;; Write a function called `sum-numbers-only` that takes a list
;;; containing mixed types (numbers, strings, symbols, etc.) and
;;; returns the sum of only the numbers in the list.
;;;
;;; Use recursion, cond, AND the number? predicate.
;;;
;;; Examples:
;;;   (sum-numbers-only '(1 "hello" 2 world 3))  => 6
;;;   (sum-numbers-only '("a" "b" "c"))          => 0
;;;   (sum-numbers-only '(10 20 30))             => 60
;;;   (sum-numbers-only '("a" 10 x "20" 30))     => 40
;;;   (sum-numbers-only '())                     => 0
;;;
;;; Hints:
;;;   - Base case: empty list sums to 0
;;;   - If (car lst) is a number, add it to the recursive sum
;;;   - Otherwise, skip it and just return the recursive sum

; Your code here:
(define (sum-numbers-only a)
  (cond ((null? a) 0)
        ((number? (car a)) (+ (car a) (sum-numbers-only (cdr a))))
        (#t (sum-numbers-only (cdr a)))))

; Test cases:
"sum-numbers-only test"
(sum-numbers-only '(1 "hello" 2 world 3))
(sum-numbers-only '("a" "b" "c"))
(sum-numbers-only '(10 20 30))
(sum-numbers-only '("a" 10 x "20" 30))
(sum-numbers-only '())


;;; ============================================================
;;; PROBLEM 7: Nested List Processing (Challenge)
;;; ============================================================
;;; Write a function called `flatten` that takes a nested list and
;;; returns a flat list containing all the elements.
;;; Use cond, recursion, and the list? predicate for type-checking.
;;;
;;; Examples:
;;;   (flatten '(1 2 3))           => '(1 2 3)
;;;   (flatten '(1 (2 3) 4))       => '(1 2 3 4)
;;;   (flatten '((1 2) (3 (4 5)))) => '(1 2 3 4 5)
;;;   (flatten '())                => '()
;;;
;;; Hints:
;;;   - Base case: empty list returns empty list
;;;   - If (car lst) is a list, recursively flatten it and APPEND
;;;     to the flattened rest
;;;   - If (car lst) is not a list, cons it onto the flattened rest
;;;   - Use (list? x) to check if x is a list

; Your code here:
(define (flatten a) ; remember, a is meant to be a list
  (cond ((null? a) '())
        ((list? (car a)) (append (flatten (car a)) (flatten (cdr a))))
        (#t (cons (car a) (flatten (cdr a))))))

; Test cases:
(flatten '(1 2 3))
(flatten '(1 (2 3) 4))
(flatten '((1 2) (3 (4 5))))
(flatten '())
