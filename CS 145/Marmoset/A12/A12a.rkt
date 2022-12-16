#lang racket

(require "RAM.rkt")

(define start (ram-store (ram-store (ram-store ram 0 0) 1 2) 2 0))

(define (Gen inp state step)
  (define inphead (if (empty? inp) empty (take inp 1)))
  (define inprest (if (empty? inp) empty (cdr inp)))
  (define (cont newinp state out)
     (if (or (eq? newinp inphead)(eq? newinp (cdr inphead)))
         (append out (Gen (append newinp inprest) state step))
         'fail))
  (step inphead state cont))

(define (step-exist inp i n state cont)
  (cond
    [(= n i) false]
    [(= (ram-fetch state i) inp) true]
    [true (cont inp (add1 i) n state cont)]))

(define (step inp state cont)
  (cond
    [(empty? inp) (cont inp state (list (ram-fetch state 0)))]
    [true (cont (cdr inp) state if-exist)]))