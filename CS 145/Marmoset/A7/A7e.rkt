#lang scheme

(require "scratchandwin.rkt")
(require "avl-cs145.rkt")

(provide playgame)

(define (unique? secret lst)
  (cond
    [(empty? lst) true]
    [(= secret (car lst)) false]
    [true (unique? secret (cdr lst))]))

(define (playgame n)
  (playgame-helper '() '() 0 n))

(define (playgame-helper runningavl cardlist i n)
  (cond
    [(= i n) cardlist]
    [true ((λ (c r l i n) ((λ (c r r2 l i n) (if (= (sizeavl r) (sizeavl r2)) (playgame-helper r l i n) (playgame-helper r2 (cons c l) (+ i 1) n))) c r (insertavl r (car (scratch c))) l i n)) (drawcard n) runningavl cardlist i n)]))