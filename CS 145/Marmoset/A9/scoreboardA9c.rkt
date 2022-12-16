#lang racket

(require "stream.rkt")
(require "total-order.rkt")
(require "ordered-set.rkt")

(provide scoreboard)

(define (scoreboard s)
  (if (stream-empty? s) s
  (stream-generate
   (list (os-singleton (to-hide (stream-car s))) (stream-cdr s) (append (stream-car s) (reverse (stream-car s))))
   (λ (x) (empty? (first x)))
   (λ (x) (if (stream-empty? (second x)) (list empty stream-empty (third x)) (scoreboard-helper (first x) (second x))))
   (λ (x) (third x)))))

(define (scoreboard-helper os stream)
  (define to-status (os-after os (os-before os (to-hide (stream-car stream)))))
  (cond
    [(not (os-member os (to-hide (stream-car stream)))) ((λ (a b) (list a (stream-cdr b) (list (first (stream-car b)) (second (stream-car b)) (second (stream-car b)) (first (to-unhide (os-op a)))))) (os-union os (os-singleton (to-hide (stream-car stream)))) stream)]
    [true ((λ (a b c) (list a (stream-cdr b) (list (first (stream-car b)) (second (stream-car b)) (+ (second (to-unhide c)) (second (stream-car b))) (first (to-unhide (os-op a)))))) (os-union (os-difference os (os-singleton (to-hide (list (first (stream-car stream)) 0)))) (os-singleton (to-hide (list (first (stream-car stream)) (+ (second (to-unhide to-status)) (second (stream-car stream))))))) stream to-status)]))