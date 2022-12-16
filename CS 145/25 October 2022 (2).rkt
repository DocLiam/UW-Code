#lang racket
; Total order on lists: lexicographic order

(define (lex< a b <)
  (cond
    [(empty? a) (not (empty? b))]
    [(empty? b) false]
    [(< (car a) (car b)) true]
    [(< (car b)(car a)) false]
    [true (lex< (cdr a) (cdr b) <)]))

(lex< '(1 2 3) '(1 2 -4) <)
(lex< '(1 2 3) '(1 2 3) <)
(lex< '(1 2 3) '(1 2 4) <)
(lex< '(1 2 3) '(1 2 -4) (lambda (a b) (< (sqr a) (sqr b))))