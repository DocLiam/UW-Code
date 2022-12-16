;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname A3b) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(define-struct node (left right))

; Part a

(define (tree-similar? tree1 tree2)
  (cond
    [(and (empty? tree1) (empty? tree2)) true]
    [(empty? tree1) false]
    [(empty? tree2) false]
    [true (and (tree-similar? (node-left tree1) (node-left tree2)) (tree-similar? (node-right tree1) (node-right tree2)))]))

; Part b

(define (tree-create n)
  (if (= n 0) empty
      (if (= (modulo n 2) 0) (make-node empty (tree-create (- n 1))) (make-node (tree-create (- n 1)) empty))))

; Part c

(define (tree-create-c n)
  (if (= n 0) empty
      (if (= (modulo n 2) 1) (make-node empty (tree-create-c (- n 1))) (make-node (tree-create-c (- n 1)) empty))))

; Part d

(define (tree-create-d n)
  (cond
    [(= n 0) empty]
    [true (make-node (tree-create-d (quotient (- n 1) 2)) (tree-create-d (- n (quotient (- n 1) 2) 1)))]))

; Part e

(define (factorial n)
  (if (< n 1) 1 (* (factorial (- n 1)) n)))

(define (tree-count n)
  (/ (factorial (* n 2)) (* (factorial (+ n 1)) (factorial n))))
  