#lang racket

(define (f x) (begin (display "Working...") (+ x 1)))

(f 4)

(define (g x) (begin (display "Working...") (newline) (+ x 1)))

(g 4)

(define (h x) (display "Working...") (newline) (+ x 1))

(h 4)