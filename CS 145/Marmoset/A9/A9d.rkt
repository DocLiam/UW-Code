#lang racket

(require "stream.rkt")
(require "total-order.rkt")
(require "ordered-set.rkt")

(provide scoreboard)

(define (scoreboard s)
  (if (stream-empty? s) s
  (stream-generate
   (list (os-singleton (to-hide (stream-car s))) (stream-cdr s) (append (stream-car s) (list (second (stream-car s)) (list->stream (list (first (stream-car s)))))))
   (λ (x) (empty? (first x)))
   (λ (x) (if (stream-empty? (second x)) (list empty stream-empty (third x)) (scoreboard-helper (first x) (second x))))
   (λ (x) (third x)))))

(define (scoreboard-helper os stream)
  (define to-status (os-after os (os-before os (to-hide (stream-car stream)))))
  (cond
    [(not (os-member os (to-hide (stream-car stream)))) ((λ (a b) (list a (stream-cdr b) (list (first (stream-car b)) (second (stream-car b)) (second (stream-car b)) (order-names a)))) (os-union os (os-singleton (to-hide (stream-car stream)))) stream)]
    [true ((λ (a b c) (list a (stream-cdr b) (list (first (stream-car b)) (second (stream-car b)) (+ (second (to-unhide c)) (second (stream-car b))) (order-names a)))) (os-union (os-difference os (os-singleton (to-hide (list (first (stream-car stream)) 0)))) (os-singleton (to-hide (list (first (stream-car stream)) (+ (second (to-unhide to-status)) (second (stream-car stream))))))) stream to-status)]))

(define (order-names os)
  (define max-e (os-op os))
  (if (empty? os) empty
  (stream-generate
   (list (os-difference os (os-singleton max-e)) max-e max-e)
   (λ (x) (empty? (second x)))
   (λ (x) (if (empty? (first x)) (list empty empty (third x)) ((λ (a b) (list (os-difference a (os-singleton b)) b b)) (first x) (os-op (first x)))))
   (λ (x) (first (to-unhide (third x)))))))