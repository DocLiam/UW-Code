#lang scheme

(require "scratchandwin.rkt")

(provide collect-prize)

(define (unique? secret lst)
  (cond
    [(empty? lst) true]
    [(= secret (car lst)) false]
    [true (unique? secret (cdr lst))]))

(define (collect-prize cardlist)
  (cond
    [(empty? cardlist) 'prize]
    [(collect-prize-helper '() cardlist 0 0) 'prize]
    [true 'fraud]))

(define (collect-prize-helper runninglist cardlist i n)
  (cond
    [(empty? cardlist) (= i n)]
    [(not (list? cardlist)) false]
    [(not (list? (scratch (car cardlist)))) false]
    [(unique? (car (scratch (car cardlist))) runninglist) (collect-prize-helper (cons (car (scratch (car cardlist))) runninglist) (cdr cardlist) (+ i 1) (car (cdr (scratch (car cardlist)))))]
    [true false]))