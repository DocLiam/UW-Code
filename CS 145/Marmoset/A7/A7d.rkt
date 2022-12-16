#lang scheme

(require "scratchandwin.rkt")

(provide collect-prize)

(define (allunique? prev lst)
  (cond
    [(empty? lst) true]
    [(= prev (car lst)) false]
    [true (allunique? (car lst) (cdr lst))]))

(define (collect-prize cardlist)
  (cond
    [(collect-prize-helper '() cardlist 0 0) 'prize]
    [true 'fraud]))

(define (collect-prize-helper runninglist cardlist i n)
  (cond
    [(empty? cardlist) (if (= i n) (allunique? 0 (sort runninglist <)) false)]
    [(not (list? cardlist)) false]
    [(not (list? (scratch (car cardlist)))) false]
    [true (collect-prize-helper (cons (car (scratch (car cardlist))) runninglist) (cdr cardlist) (+ i 1) (car (cdr (scratch (car cardlist)))))]))