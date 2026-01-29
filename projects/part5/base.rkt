#lang racket

(require "defs.rkt")
(require 2htdp/image)

;; Base Classes
(define scene-obj-interface
  (interface ()
    [render   (->m number? image? image?)] ;; ->m is saying it has to have a method (m) of the following args and return
    [update   (->m void?)]
    [visible? (->m number? boolean?)]
    )
  )

;; NOTE: Got help from Gemini to understand classes syntax https://gemini.google.com/share/b3bc3a9c6f2f

;; The goal of this is to abstract away the most possible rendering logic
;; This should handle all of the rendering logic
;; so that the implementations (individual objects) only need to define the image it's using
;; and define the way that it should be updating
(define base-obj%
  (class* object% (scene-obj-interface)
    (init-field z-pos) ;; Required
    (init-field x-world) ;; Required, but this should probably just be 
    (field [scl (/ FOCAL_LENGTH (+ FOCAL_LENGTH z-pos))])

    (field [img empty-image]) ;; To be set by the implementations

    ;; Can be overriden for dynamic objects
    (define/public (update)
      ;; Does nothing normally
      )

    ;; Should't be overriden
    (define/public (render x-camera scene)
      (define x-screen-center (/ SCENE-WIDTH 2))
      (define x-screen (+ x-screen-center (* (get-scl) (- x-world x-camera)))) ;; (world-x - camera-x) * scale + screen-center

      (define y-screen (+ HORIZON_HEIGHT (* (get-scl) CAMERA_HEIGHT))) ;; horizon-y + (camera-y * scale)

      (place-image/align
        (scale (get-scl) (get-img))
        x-screen y-screen "center" "bottom"
        scene
        )
      )

    ;; To know when objects are out of frame so they can be removed from the list
    (define/public (visible? x-camera)
      (define x-screen-center (/ SCENE-WIDTH 2))
      (define x-screen (+ x-screen-center (* (get-scl) (- x-world x-camera)))) ;; (world-x - camera-x) * scale + screen-center

      (> (+ screen-x (* width scale)) 0) ;; TODO: How can this also check for the width of the image?
      ;; Wouldn't this remove it as soon as it hits the edge?
      )

    )
  )
