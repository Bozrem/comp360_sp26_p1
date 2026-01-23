#lang racket
(require 2htdp/image)
(require 2htdp/universe)
(require lang/posn)

(provide (all-defined-out))

;; Outside of Dr Racket, images don't show automatically. I need to define a universe to show it
(define (show img)
  (big-bang 0 (to-draw (lambda (w) img)))
  )
;; got a bit of help defining this (https://gemini.google.com/share/a3e3ef55a044)


;;; Part 1: Racket and Image Basics

; 1.1: Colored Circle
(define (colored-circle rad color)
  (circle rad "solid" color)
  )

; 1.2: Bullseye
(define (make-bullseye inrad inr ing inb outrad outr outg outb)
  (overlay
    (circle inrad "solid" (make-color inr ing inb))
    (circle outrad "solid" (make-color outr outg outb))
    )
  )

; 1.3: Colored Square
(define (make-square r g b side)
  (square side "solid" (make-color r g b))
  )

; 1.4: Gray Square
(define (grayscale-square lum side)
  (square side "solid" (make-color lum lum lum))
  )



;;; Part 2: Combining Shapes

; 2.1: Traffic Light
(define (traffic-light)
  (above
    (circle 100 "solid" "red")
    (circle 100 "solid" "yellow")
    (circle 100 "solid" "green")
    )
  )

; 2.2: Simple House
(define (simple-house)
  (above
    (isosceles-triangle 100 120 "solid" "red")
    (square 100 "solid" "brown")
    )
  )

; 2.3: Tree
(define (tree)
  (define trunk (rectangle 50 150 "solid" "brown"))
  (define leaves (isosceles-triangle 200 55 "solid" "medium forest green")) ;; Found the fancy list https://docs.racket-lang.org/draw/color-database___.html

  (overlay/offset leaves 0 50 trunk)
  )

; 2.4: Car
(define (make-car color)
  (define wheel (make-bullseye 35 0 0 0 45 100 100 100))

  (define body (polygon (list
        (make-posn 0 280)   ;; Front bumper
        (make-posn 0 220)   ;; Hood front
        (make-posn 100 190) ;; Hood slant ends
        (make-posn 180 190) ;; Base of windshield
        (make-posn 260 150) ;; Top of windshield
        (make-posn 340 150) ;; End of roof
        (make-posn 440 170) ;; End of back window
        (make-posn 500 170) ;; Spoiler
        (make-posn 500 250) ;; Trunk
        (make-posn 430 300) ;; Slope back to tire
        (make-posn 30 300)  ;; Base of car
      )
      "solid"
      color)) ;; Couldn't not use this name

  (define window (polygon (list
        (make-posn 170 200) ;; Base of windshield
        (make-posn 250 160) ;; Top of windshield
        (make-posn 330 160) ;; End of roof
        (make-posn 420 180) ;; End of back window
        (make-posn 410 200)
      )
      "solid"
      "white smoke"))

  (define bw (overlay/offset window -55 45 body))

  (define bw_lwheel (overlay/offset wheel 175 -55 bw))

  (overlay/offset wheel -150 -45 bw_lwheel)
  )



;;; Part 3:

; 3.1: color->make-color
(define (color->make-color rgb)
  (make-color (first rgb) (second rgb) (third rgb))
  )

; 3.2: darker
(define (darker rgb)
  (define (darken val) (inexact->exact (floor (* 0.8 val))))

  (cond
    [(empty? rgb) rgb]
    [else         (cons (darken (first rgb)) (darker (rest rgb)))]
    )
  )

; 3.3: blend
(define (blend rgb_one rgb_two)
  (define (blend_val val_one val_two) (inexact->exact (floor (/ (+ val_one val_two) 2))))

  (cond
    [(empty? rgb_one) empty] ;; Technically I should account for different lengths, but idk exceptions yet
    [else             (cons (blend_val (first rgb_one) (first rgb_two)) (blend (rest rgb_one) (rest rgb_two)))]
    )
  )

; 3.4: get-x and get-y
(define (get-x pair) (car pair))
(define (get-y pair) (cdr pair))

; 3.5: place-image-at
(define (place-image-at img1 point img2)
  (place-image img1 (get-x point) (get-y point) img2)
  )

; 3.6: place-all
(define (place-all points img1 img2)
  (cond
    [(empty? points)  img2]
    [else             (place-image-at img1 (first points) (place-all (rest points) img1 img2))]
    )
  )


; Test all of your functions before moving on!!


;;; Part 4: Recursion with Graphics

; 4.1: Row of Images


; 4.2: Column of Images


; 4.3: Grid of Images


; 4.4: Forest




; Test your functions before moving on!!


;;; Part 5: Your Scene

; Make something cool!

;;; Example: I used AI for a very small slice of my scene.
;;;          If you want to see my conversation, I am happy to show it to you.

(define (scene width depth color rotation)
  (define (darker color-list by) ; rewritten for more control
    (make-color (floor (* (car by) (car color-list))) ; R
                (floor (* (car (cdr by)) (car (cdr color-list)))) ; G
                (floor (* (car (cdr (cdr by))) (car (cdr (cdr color-list))))))) ; B
  
  ; scale-factor is a function written by me but
  ; mathematically described by Claude AI
  (define scale-factor (/ 1 (+
                             (cos (degrees->radians (abs rotation)))
                             (sin (degrees->radians (abs rotation))))))
  
  (define new-width (* width scale-factor))

  (define (color->color-list c) ; for use with darker
    (list (color-red c) (color-green c) (color-blue c)))
  
  (if (= depth 0) ; main
      (rectangle width width "solid" color)
      (overlay (rotate rotation (scene new-width
                                       (- depth 1)
                                       (darker (color->color-list color) '(0.7 0.7 0.95)) rotation))
               (rectangle width width "solid" color)))
  ; possible extensions:
  ; each square has a random color
  ; each square has a random rotation
  ; the randomness is a tunable parameter: ex, color-randomness ranges from 0 to 1
  ; different shapes
  )


(scene 200 6 (make-color 100 100 255) -15)
