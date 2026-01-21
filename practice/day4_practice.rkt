#lang racket
;;; COMP 360 - Day 4 In-Class Practice
;;; Building a Course Registration System
;;;
;;; A "course section" is a pair: (cons course-number enrollment)
;;;    Ex: (cons 'comp-172 14) represents COMP 172 with 14 students.

;;; Here is some sample data:
(define courses
         (list (cons 'comp-172 14)
               (cons 'comp-141-01 25)
               (cons 'comp-355 9)
               (cons 'comp-141-02 25)
               (cons 'comp-251 17)))

;;; ============================================================
;;; PROBLEM 1: Helper Functions
;;; ============================================================

;;; a. Write 'get-number' that takes a course section and evaluates
;;;    to the course number: (get-number (cons 'comp-172 14)) => 'comp-172

; Your code here:


;;; a. Write 'get-enrollment' that takes a course section and evaluates
;;;    to the course enrollment (get-number (cons 'comp-172 14)) => 14

; Your code here:


;;; c. Write 'at-capacity?' that takes a course section and returns #t
;;;    if enrollment is 25.
;;;    Ex: (at-capacity? (cons 'comp-172 14)) => #f
;;;        (at-capacity? (cons 'comp-141 25)) => #t

; Your code here:


;;; d. Write 'makes?' that takes a course section and returns #t if
;;;    enrollment is 10 or more.
;;;    Ex: (makes? (cons 'comp-172 14)) => #t
;;;        (makes? (cons 'comp-360 9))  => #f

; Your code here:


;;; ============================================================
;;; PROBLEM 2: Recursion with cond
;;; ============================================================

;;; a. Write 'count-full' that takes a list of course sections
;;;    and returns how many courses are at capacity.
;;;    Ex: (count-full courses) => 2
;;;
;;;    Hint: your cond could look like this:
;;;      - empty course list? => 0
;;;      - first entry full?  => 1 + recursion on rest
;;;      - else:              => recursion on rest

; Your code here:


;;; b. Write 'courses-that-wont-make' which takes a list of course
;;;    course sections and returns a list of course names which won't
;;;    make with the current enrollment. Use recursion, cond, and helpers.
;;;    Ex: (courses-that-wont-make courses) => '(comp-355)

; Your code here:


;;; c. Write 'total-enrollment' which takes a list of course sections
;;;    and returns the total enrollment **only in courses that will make**.
;;;    Ex: (total-enrollment courses) => 81

; Your code here:


;;; ============================================================
;;; PROBLEM 3: Function Composition
;;; ============================================================

;;; a. Write 'average-enrollment' which takes a list of course sections
;;;    and returns the average enrollment **only in courses that will make**.
;;;    Use total-enrollment and the built-in (length lst) function.
;;;    Multiply by 1.0 for a decimal result.


;;; b. Write 'total-students-under' which takes a list of course sections
;;;    and returns the total number of students in classes that won't make.
;;;    Feel free to write new helper functions, but it is possible to write
;;;    this one using only the functions you've already made.
;;;    Ex: (total-students-under courses) => 9

; Your code here:


;;; ============================================================
;;; PROBLEM 4: Building Complex Data Structures
;;; ============================================================

;;; A "course status" is a list with three elements:
;;;    (list course-number enrollment status)
;;; where status is one of: 'open, 'full, or 'cancelled
;;;
;;; Examples:
;;;    (list 'comp-172 14 'open)      ; 14 students, has space
;;;    (list 'comp-141-01 25 'full)   ; at capacity
;;;    (list 'comp-355 9 'cancelled)  ; won't make

;;; a. Write 'get-status' that takes a course section and returns
;;;    its status symbol: 'cancelled if < 10, 'full if = 25, else 'open
;;;    Ex: (get-status (cons 'comp-172 14)) => 'open
;;;        (get-status (cons 'comp-141 25)) => 'full
;;;        (get-status (cons 'comp-355 9))  => 'cancelled

; Your code here:


;;; b. Write 'make-course-status' that takes a course section and
;;;    returns a course status list. Use your helpers!
;;;    Ex: (make-course-status (cons 'comp-172 14))
;;;        => '(comp-172 14 open)

; Your code here:


;;; c. Write 'generate-report' that takes a list of course sections
;;;    and returns a list of course status lists.
;;;    Ex: (generate-report courses) =>
;;;        '((comp-172 14 open) (comp-141-01 25 full) (comp-355 9 cancelled)
;;;          (comp-141-02 25 full) (comp-251 17 open))

; Your code here:



;;; ============================================================
;;; PROBLEM 5: Putting It All Together
;;; ============================================================

;;; Write 'registration-summary' that takes a list of course sections
;;; and returns a list containing THREE elements:
;;;   1. Total number of students enrolled in courses that will make
;;;   2. A list of course numbers that are full (at capacity)
;;;   3. A list of course numbers that are cancelled (won't make)
;;;
;;; Ex: (registration-summary courses) => '(81 (comp-141-01 comp-141-02) (comp-355))
;;;
;;; Hints:
;;;   - You've already written most of the pieces you need!
;;;   - Use (list a b c) to build the three-element result
;;;   - You may need one new helper to get names of full courses

; Your code here: