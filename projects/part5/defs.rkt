#lang racket

(provide (all-defined-out))

(require 2htdp/image)
(require 2htdp/universe)

;; High definition
(define SCENE_HEIGHT 720)
(define SCENE_WIDTH  1280)

(define BACKGROUND (rectangle SCENE_WIDTH SCENE_HEIGHT "solid" "white"))

;; Base Classes
(define scene-obj-interface
  (interface ()
    [render (->m image? image?)] ;; ->m is saying it has to have a method (m) of the following args and return
    [update (->m void?)]
    )
  )


;; TODO: Move these to args
(define CAR_COLOR "dodger blue")



;; Simple show for debug
(define (show img)
  (big-bang 0 (to-draw (lambda (w) img)))
  )
