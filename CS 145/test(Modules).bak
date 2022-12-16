#lang racket

(provide mysumto myfact)

(define (thingto n f z) (if (zero? n) z (f n (thingto (sub1 n) f z))))

(define mysumto (lambda (n) (thingto n + 0)))
(define myfact (lambda (n) (thingto n + 1)))