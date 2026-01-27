#lang racket

(require 2htdp/image)
(require lang/posn)
(require "defs.rkt")

(provide car%)

(define (make-car)
  (define wheel
    (overlay
      (circle 35 "solid" "dark gray")
      (circle 45 "solid" "dim gray")
      )
    )

  (define body (polygon (list
        (make-posn 500 130) ;; Front bumper
        (make-posn 500 70)  ;; Hood front
        (make-posn 400 40)  ;; Hood slant ends
        (make-posn 320 40)  ;; Base of windshield
        (make-posn 240 0)   ;; Top of windshield
        (make-posn 160 0)   ;; End of roof
        (make-posn 60  20)  ;; End of back window
        (make-posn 0   20)  ;; Spoiler
        (make-posn 0   100) ;; Trunk
        (make-posn 70  150) ;; Slope back to tire
        (make-posn 470 150) ;; Base of car
      )
      "solid"
      CAR_COLOR))

  (define window (polygon (list
        (make-posn 330 50) ;; Base of windshield
        (make-posn 250 10) ;; Top of windshield
        (make-posn 170 10) ;; End of roof
        (make-posn 80  30) ;; End of back window
        (make-posn 90  50) ;; NOTE: I made gemini invert the x values so it faces the right way
      )
      "solid"
      "white smoke"))

  (define bw (overlay/offset window 55 45 body))

  (define bw_lwheel (overlay/offset wheel -175 -55 bw))

  (overlay/offset wheel 150 -45 bw_lwheel)
  )

(define CAR_IMG (make-car))

(define car%
  (class* object% (scene-obj-interface)
    ;; fields
    (init-field [SCALE 1]) ;; 1 is the default scale
    (init-field [x-pos 0])
    (init-field [y-pos (/ SCENE_HEIGHT 2)]) ;; Halfway up is default

    (super-new) ;; Constructor ish

    (field [y-inc -10])

    (define/public (update)
      (set! y-pos (+ y-pos y-inc))
      (set! y-inc (* y-inc -1))
      )

    (define/public (render scene)
      (place-image/align CAR_IMG x-pos y-pos "left" "top" scene)
      )
    )
  )

;; (show CAR_IMG)
