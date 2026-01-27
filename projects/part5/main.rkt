#lang racket

(require 2htdp/image)
(require 2htdp/universe)
(require "defs.rkt")
(require "car.rkt")

(define INIT_SCENE
  (list
    (new car% [y-pos 400])
    )
  )

;; high-level renderer
(define (render-scene objs)
  (cond
    [(empty? objs)  BACKGROUND]
    [else           (send (first objs) render (render-scene (rest objs)))]
    )
  )


;; high-level updater
(define (update-scene objs)
  (cond
    [(empty? objs)  empty]
    [else
      (send (first objs) update)
      (cons (first objs) (update-scene (rest objs)))
      ]
    )
  )


;; Be able to quit with just q instead of ctrl+c
(define (handle-quit objs key)
  (cond
    [(string=? key "q")   (stop-with objs)]
    [else                 objs]
    )
  )

;; Scene loop handler
(big-bang INIT_SCENE
  (to-draw render-scene)
  (on-tick update-scene 0.5)
  (on-key  handle-quit)
  (close-on-stop #t) ;; lets handle quit work
  )

