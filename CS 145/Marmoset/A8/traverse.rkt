#lang racket

(require "generate.rkt")
(require "btree.rkt")

(define (traverse t)
  (generate
   (list '() (list t))
   (λ (x) (or (bt-empty? (second x)) (bt-empty? (first (second x)))))
   (λ (x) (if (bt-empty? (bt-right (first (second x)))) (list (cons (bt-dec (first (second x))) (first x)) (if (bt-empty? (bt-left (first (second x)))) (rest (second x)) (cons (bt-left (first (second x))) (rest (second x))))) (list (first x) (cons (bt-right (first (second x))) (cons (make-bt (bt-left (first (second x))) (bt-dec (first (second x))) bt-empty) (rest (second x)))))))
   (λ (x) (first x))))