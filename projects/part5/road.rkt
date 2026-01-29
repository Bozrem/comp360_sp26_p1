#lang racket

(require 2htdp/image)
(require "defs.rkt")
(require "base.rkt")

(define road-base%
  (class* base-obj% (scene-obj-interface)

    (super-new) ;; Constructor ish

    (define/public (update)
      ;; Does nothing for now
      )

    (define/public (render scene)
      (place-image/align ROAD_BASE_IMG x-pos y-pos "left" "top" scene)
      )
    )
  )
