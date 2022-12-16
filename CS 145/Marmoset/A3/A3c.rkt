;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname A3c) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(define-struct node (left right))

; Part f

(define (tree-height tree)
  (cond
    [(empty? tree) 0]
    [true (+ (max (tree-height (node-left tree)) (tree-height (node-right tree))) 1)]))

; Part g

(define (tree-create-max n)
  (if (= n 0) empty (make-node empty (tree-create-max (- n 1)))))

; Part h

(define (tree-create-min n)
  (cond
    [(= n 0) empty]
    [true (make-node (tree-create-min (quotient (- n 1) 2)) (tree-create-min (- n (quotient (- n 1) 2) 1)))]))

; Part i

(define (tree-count-max n)
  (cond
    [(< n 2) 1]
    [true (* (tree-count-max (- n 1)) 2)]))

; Part j

(define (log2 n)
  (if (< n 2) 0 (+ (log2 (quotient n 2)) 1)))

(define (factorial n)
  (if (< n 2) 1 (* (factorial (- n 1)) n)))

(define (choose n r)
  (/ (factorial n) (* (factorial r) (factorial (- n r)))))

(define (tree-count n)
  (/ (factorial (* n 2)) (* (factorial (+ n 1)) (factorial n))))

;(define (tree-count-min-old n)
  ;(choose (expt 2 (log2 (+ n 1))) (- n (- (expt 2 (log2 (+ n 1))) 1))))

(define (tree-combos n)
  (choose (expt 2 (log2 (+ n 1))) (+ (- n (expt 2 (log2 (+ n 1)))) 1)))

(define (sum-root root k level)
  (if (< root (+ k 1)) (+ (* (if (= root 1) 1 (f (- root 1) (- level 1))) (if (= root k) 1 (f (- k root) (- level 1)))) (sum-root (+ root 1) k level)) 0))

(define (f k level)
  (cond
    [(or (> k (expt 2 level)) (= k (expt 2 level))) 0]
    [true (sum-root 1 k level)]))

(define (tree-count-min n)
  (cond
    [(= (expt 2 (log2 (+ n 1))) (+ n 1)) 1]
    [(= (expt 2 (log2 (+ n 2))) (+ n 2)) (expt 2 (- (log2 (+ n 2)) 1))]
    [true (f n (+ 1 (log2 n)))]))
