#lang racket

(provide drawcard scratch)
(provide card-secret card-n)

(define-struct card (secret n))

(define (drawcard n)
  (make-card (+ 1 (random n)) n))

(define (scratch card)
  (cond
    [(and (card? card) (>= (card-n card) (card-secret card) 1)) (list (card-secret card) (card-n card))]
    [true 'fraud]))