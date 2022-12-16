#lang racket

(provide make-bt bt-insert bt-left bt-right bt-dec bt-empty bt-empty?)
;(provide make-bt bt-insert bt-left bt-right bt-dec bt-empty bt-empty? bt-list)

(define-struct bt (left dec right))
(define bt-empty? empty?)
(define bt-empty empty)
(define (bt-insert e t)
  (cond
    [(empty? t)(make-bt empty e empty)]
    [(zero? (random 2))(make-bt (bt-insert e (bt-left t)) (bt-dec t)(bt-right t))]
    [true (make-bt (bt-left t)(bt-dec t)(bt-insert e (bt-right t)))]))
(define (bt-list t)
  (cond
    [(empty? t) empty]
    [true (append (bt-list (bt-left t))(list (bt-dec t))(bt-list (bt-right t)))]))

;(bt-list (foldl bt-insert empty (build-list 10 add1)))