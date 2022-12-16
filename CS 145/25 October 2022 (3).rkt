#lang racket
; Sorting

(define lst (build-list 10 (lambda (x) (- (random 11) 5))))

lst

(sort lst <)
(sort lst >)
(sort lst (lambda (a b) (< (sqr a) (sqr b))))

(define (insert e lst <)
  (cond
    [(empty? lst) (list e)]
    [(< (car lst) e) (cons (car lst) (insert e (cdr lst) <))]
    [true (cons e lst)]))

(insert 5 (insert 20 (insert 10 empty <) <) <)
(foldl (lambda (a b) (insert a b <)) empty (build-list 10 (lambda (x) (random 10))))
(define lst (build-list 10 (lambda (x) (random 10))))

(define (Sort x <)
  (foldl (lambda (a b) (insert a b <)) empty x))