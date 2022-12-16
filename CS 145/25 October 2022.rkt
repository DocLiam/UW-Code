#lang racket
(require "bst.rkt")
(define lst (build-list 10 (lambda (x) (- (random 11) 5))))
(define t1 (foldl Bstinsert (Bstempty <) lst))
(define t2 (foldl Bstinsert (Bstempty >) lst))

(define (mag< a b) (< (sqr a) (sqr b)))
(define t3 (foldl Bstinert (Bstempty mag<) lst))

lst
(Bstlist t1)
(Bstlist t2)
(Bstlist t3)