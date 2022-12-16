#lang racket
; BST for any strict total order LT

(provide Bstempty Bstinsert Bstmember)

(define-struct bst (t LT))

(define (Bstempty LT) (make-bst empty LT))
(define (Bstinsert e t) (make-bst (bstinsert e (bst-t t) (bst-LT t))))
(define (Bstmember e t) (bstmember e (bst-t t) (bst-LT t)))

(define-struct node (l k r))

(define bstempty empty)
(define (bstinsert e t LT)
  (cond
    [(empty? t) (make-node empty e empty)]
    [(LT e (node-k t)) (make-node (bstinsert e (node-l t) LT)
                                  (node-k t)
                                  (node-r t))]
    [(LT (node-k t) e) (make-node (node-l t)
                                  (node-k t)
                                  (bstinsert e (node-r t) LT))]
    [true t]))

(define (bstmember e t LT)
  (cond
    [(empty? t) false]
    [(LT e (node-k t)) (bstmember e (node-l t) LT)]
    [(LT (node-k t) e) (bstmember e (node-r t) LT)]
    [true true]))

(define (bstlist t)
  (cond
    [(empty? t) empty]
    [true (append (bstlist (node-l t)) (list (node-k t)) (bstlist (node-r t)))]))

(define x (Bstinsert 0 (Bstinsert 15 (Bstinsert 10 (Bstempty <)))))
(Bstmember 10 x)
(Bstmember 0 x)
(Bstmember 15 x)
(bstlist (bst-t x))