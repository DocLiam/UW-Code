#lang racket

; if without if or cond
; (If tst tru fls)

; True and False without true and false

(define True (λ (x y) x))
(define False (λ (x y) y))

(define mystery (list-ref (list True False) (random 2)))

(mystery 'fred 'wilma)

(define (If tst tru fls)
  (tst tru fls))

(define (Cons car cdr)
  (λ (s) (s car cdr)))

(define x (Cons 'homer 'marge))

(define Empty (λ (x) True))

(define (Empty? c) (c (λ (x y) False)))