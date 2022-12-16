#lang racket

(require "stream.rkt")
(require "total-orderA9b.rkt")
(require "ordered-set.rkt")

(provide count)

(define (count s)
  (if (stream-empty? s) s
  (stream-generate
   (list (os-singleton (to-hide (list (stream-car s) 0))) (stream-cdr s) (list (stream-car s) 0))
   (λ (x) (empty? (first x)))
   (λ (x) (if (stream-empty? (second x)) (list empty stream-empty (third x)) (count-fetch (first x) (second x))))
   (λ (x) (third x)))))

(define (count-fetch os stream)
  (define number (stream-car stream))
  (define before-pair (to-unhide (os-before os (to-hide (list number +inf.0)))))
  (cond
    [(= (first before-pair) number) (list (os-union os (os-singleton (to-hide (list (first before-pair) (add1 (second before-pair)))))) (stream-cdr stream) (list (first before-pair) (add1 (second before-pair))))]
    [true (list (os-union os (os-singleton (to-hide (list number 0)))) (stream-cdr stream) (list number 0))]))
  