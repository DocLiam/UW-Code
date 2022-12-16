;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname A3d) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(define-struct node (left right))

(define (min-depth-empty tree n)
  (cond
    [(empty? tree) n]
    [true (min (min-depth-empty (node-left tree) (+ n 1)) (min-depth-empty (node-right tree) (+ n 1)))]))

(define (rebuild-helper-left rebuilt-left-subtree i n tree)
  (if (node? rebuilt-left-subtree) (make-node rebuilt-left-subtree (node-right tree)) (rebuild-helper-right (rebuild (node-right tree) (+ i 1) n) tree)))

(define (rebuild-helper-right rebuilt-right-subtree tree)
  (if (node? rebuilt-right-subtree) (make-node (node-left tree) rebuilt-right-subtree) false))

(define (rebuild tree i n)
  (if (= n i) (if (empty? tree) (make-node empty empty) false) (rebuild-helper-left (rebuild (node-left tree) (+ i 1) n) i n tree)))

(define (tree-grow-min tree)
  (rebuild tree 0 (min-depth-empty tree 0)))



(define (rebuild-helper-shrink-left rebuilt-left-subtree i n tree)
  (if (not (equal? rebuilt-left-subtree false)) (make-node rebuilt-left-subtree (node-right tree)) (rebuild-helper-shrink-right (rebuild-shrink (node-right tree) (+ i 1) n) tree)))

(define (rebuild-helper-shrink-right rebuilt-right-subtree tree)
  (if (not (equal? rebuilt-right-subtree false)) (make-node (node-left tree) rebuilt-right-subtree) false))

(define (rebuild-shrink tree i n)
  (if (empty? tree) false (if (= n i) (if (and (empty? (node-left tree)) (empty? (node-right tree))) empty false) (rebuild-helper-shrink-left (rebuild-shrink (node-left tree) (+ i 1) n) i n tree))))

(define (log2 n)
  (if (< n 2) 0 (+ (log2 (quotient n 2)) 1)))

(define (make-node-duplicate subtree)
  (make-node subtree subtree))

(define (build-perfect-tree i h)
  (cond
    [(= i h) empty]
    [(= i (- h 1)) (make-node empty empty)]
    [true (make-node-duplicate (build-perfect-tree (+ i 1) h))]))

(define (count-nodes tree)
  (cond
    [(empty? tree) 0]
    [true (+ 1 (count-nodes (node-left tree)) (count-nodes (node-right tree)))]))

(define (is-power2? n)
  (= (expt 2 (floor (log n 2))) n))

(define (generate-tree tree n)
  (if (is-power2? n) (build-perfect-tree 0 (log2 n)) (rebuild-shrink tree 0 (log2 n))))

(define (tree-shrink-min tree)
  (generate-tree tree (count-nodes tree)))


(define (tree-create-min n)
  (cond
    [(= n 0) empty]
    [true (make-node (tree-create-min (quotient (- n 1) 2)) (tree-create-min (- n (quotient (- n 1) 2) 1)))]))