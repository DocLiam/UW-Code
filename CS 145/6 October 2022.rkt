#lang racket

(provide mysumto myfact)

(define (sumto n) (if (zero? n) 0 (+ n (sumto (sub1 n)))))

(define (thing f n) ; a function that takes a function and applies it to a parameter
  (f n))

(define (bork x) ; a function that returns a function for all inputs
  sumto)

(define (thingto n f z) (if (zero? n) z (f n (thingto (sub1 n) f z))))

;(thingto 10 + 0)
;(thingto 10 * 1)
;(thingto 10 (lambda (a b) (+ a a b)) 0)

;(define (double x) (+ x x))
(define double (lambda (x) (+ x x)))
(double 10)

(define (adder n)
  (lambda (x) (+ x n)))

(define add3 (adder 3))
(procedure? add3)

(define mysumto (lambda (n) (thingto n + 0)))
(define myfact (lambda (n) (thingto n + 1)))


(define (foo y)
  (define (foofoo x) (if (zero? x) 1 (+ x (foofoo sub1 x))))
  (define q 99)
  (+ (foofoo y) q))