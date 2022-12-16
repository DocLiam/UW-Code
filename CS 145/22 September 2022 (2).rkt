;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname |22 September 2022 (2)|) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
; BST on real numbers in ascending order

(define-struct node (left dec right))

(define (insb e t) ; insert element into bst t
  (cond
    [(empty? t) (make-node empty e empty)]
    [(< e (node-dec t)) (make-node
                         (insb e (node-left t))
                         (node-dec t)
                         (node-right t))]
    [(< (node-dec t) e) (make-node
                         (node-left t)
                         (node-dec t)
                         (insb e (node-right t)))]
    [true t]))


(define t1 (insb 20 empty))
(define t2 (insb 40 t1))
(define t3 (insb 10 t2))
(define t4 (insb 30 t3))
(define t5 (insb 50 t4))
