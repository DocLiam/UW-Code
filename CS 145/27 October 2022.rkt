#lang racket

(require "stream.rkt")

(define (fibs n)
  (define-struct f (cur next))
  (stream-generate
   (make-f 0 1)
   ;(lambda (s) (>= (f-next s) n))
   (lambda (s) false) ; infinite stop when next fib too big
   (lambda (s) (make-f