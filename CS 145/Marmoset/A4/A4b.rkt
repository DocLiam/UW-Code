;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname A4b) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(define-struct node (left right key))
     
(define (insert-bst t n)
  (cond
    [(empty? t) (make-node empty empty n)]
    [(= (node-key t) n) t]
    [(< (node-key t) n) (make-node (node-left t) (insert-bst (node-right t) n) (node-key t))]
    [true (make-node (insert-bst (node-left t) n) (node-right t) (node-key t))]))

(define (find-in-order-greater t)
  (cond
    [(empty? (node-left t)) (node-key t)]
    [true (find-in-order-greater (node-left t))]))

(define (rebuild-in-order-greater t)
  (cond
    [(empty? (node-left t)) (node-right t)]
    [true (make-node (rebuild-in-order-greater (node-left t)) (node-right t) (node-key t))]))

(define (make-node-find-first t in-order)
  (make-node (node-left t) (rebuild-in-order-greater (node-right t)) in-order))
             
(define (delete-helper t)
  (cond
    [(and (empty? (node-left t)) (empty? (node-right t))) empty]
    [(empty? (node-left t)) (node-right t)]
    [(empty? (node-right t)) (node-left t)]
    [true (make-node-find-first t (find-in-order-greater (node-right t)))]))

(define (delete-bst t n)
  (cond
    [(empty? t) empty]
    [(= (node-key t) n) (delete-helper t)]
    [(< (node-key t) n) (make-node (node-left t) (delete-bst (node-right t) n) (node-key t))]
    [true (make-node (delete-bst (node-left t) n) (node-right t) (node-key t))]))

(define (combine-bst t1 t2)
  (cond
    [(empty? t2) t1]
    [true (insert-bst (combine-bst (combine-bst t1 (node-left t2)) (node-right t2)) (node-key t2))]))