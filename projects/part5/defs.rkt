#lang racket

(provide (all-defined-out))

(require 2htdp/image)
(require 2htdp/universe)

;; High definition
(define SCENE_HEIGHT 720)
(define SCENE_WIDTH  1280)
;; This means that every FOCAL_LENGTH increase in Z will half the size
(define FOCAL_LENGTH 200)

;; Also TODO: Change these to parameters to make Racket happier
(define CAMERA_HEIGHT 200) ;; TODO: Play with this value
(define ROAD_HEIGHT 300) ;;   same
(define HORIZON_HEIGHT 500) ;; same

(define ROAD_COLOR "dim gray")
(define GROUND_COLOR "brown")
(define SKY_COLOR "sky blue")

(define (get-background)
  (above
    (rectangle SCENE_WIDTH (- SCENE_HEIGHT HORIZON_HEIGHT) "solid" SKY_COLOR)
    (rectangle SCENE_WIDTH HORIZON_HEIGHT "solid" GROUND_COLOR)
    )
  )



;; TODO: Move these to args
(define CAR_COLOR "dodger blue")

(define ROAD_DASH_COLOR "gold")



;; Simple show for debug
(define (show img)
  (big-bang 0 (to-draw (lambda (w) img)))
  )

(show BACKGROUND)
