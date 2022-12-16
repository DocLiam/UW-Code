;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname A4a) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(define-struct node (left right sz))



(define (tree-grow-min tree)
  (cond
    [(empty? tree) (make-node empty empty 1)]
    [(and (empty? (node-left tree)) (empty? (node-right tree))) (make-node (make-node empty empty 1) empty 2)]
    [(empty? (node-right tree)) (make-node (node-left tree) (make-node empty empty 1) (+ (node-sz tree) 1))]
    [(empty? (node-left tree)) (make-node (make-node empty empty 1) (node-right tree) (+ (node-sz tree) 1))]
    [(>= (node-sz (node-left tree)) (node-sz (node-right tree))) (make-node (node-left tree) (tree-grow-min (node-right tree)) (+ (node-sz tree) 1))]
    [true (make-node (tree-grow-min (node-left tree)) (node-right tree) (+ (node-sz tree) 1))]))



(define (log2 n)
  (if (< n 2) 0 (+ (log2 (quotient n 2)) 1)))

(define (make-node-duplicate subtree)
  (make-node subtree subtree (+ (* 2 (node-sz subtree)) 1)))

(define (build-perfect-tree i h)
  (cond
    [(= i h) empty]
    [(= i (- h 1)) (make-node empty empty 1)]
    [true (make-node-duplicate (build-perfect-tree (+ i 1) h))]))

(define (is-power2? n)
  (= (expt 2 (floor (log n 2))) n))

(define (tree-shrinker tree)
  (cond
    [(and (empty? (node-left tree)) (empty? (node-right tree))) empty]
    [(empty? (node-right tree)) (make-node (tree-shrinker (node-left tree)) empty (- (node-sz tree) 1))]
    [(empty? (node-left tree)) (make-node empty (tree-shrinker (node-right tree)) (- (node-sz tree) 1))]
    [(>= (node-sz (node-left tree)) (node-sz (node-right tree))) (make-node (tree-shrinker (node-left tree)) (node-right tree) (- (node-sz tree) 1))]
    [true (make-node (node-left tree) (tree-shrinker (node-right tree)) (- (node-sz tree) 1))]))

(define (tree-shrink-min tree)
  (cond
    [(is-power2? (node-sz tree)) (build-perfect-tree 0 (log2 (node-sz tree)))]
    [true (tree-shrinker tree)]))



(define (tree-create-min n)
  (cond
    [(= n 0) empty]
    [true (make-node (tree-create-min (quotient (- n 1) 2)) (tree-create-min (- n (quotient (- n 1) 2) 1)) n)]))