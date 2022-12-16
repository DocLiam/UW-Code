;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname |22 September 2022|) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
; a (size-decorated) tre

(define-struct node (left right sz))

(define (mknode l r)
  (make-node l r (+ 1 (tsize l) (tsize r))))

(define (tsize t) ;; number of nodes in t
  (cond
    [(empty? t) 0]
    [true (+ 1 (tsize (node-left t))(tsize (node-right t)))]))
  
(define t0 empty) ; empty tree
(define t1 (mknode t0 t0)) ; single element
(define t2 (mknode empty t1)) ; two elements
(define t2a (mknode t1 empty)) ; a different tree with 2 elements
(define t3 (mknode t1 t1)) ; 3 elements
(define t3a (mknode t2 empty)) ; a different tree with 3 elements
(define t3b (mknode t2a empty)) ; and another
(define t3c (mknode empty t2a)) ; and another
(define t7 (mknode t3 t3)) ; 7 elts
(define t15 (mknode t7 t7)) ; 15 elts
(define t31 (mknode t15 t15)) ; 31 elts
(define t7a (mknode t3a t3b))
(define t15a (mknode t7a t7))
(define t31a (mknode t15a t15))

(define (tbuild n) ;; tree of size n
  (cond
    [(zero? n) empty]
    [true (mknode empty (tbuild (sub1 n)))]))

(define (tb n) ;; tree of size n
  (cond
    [(zero? n) empty]
    [(odd? n) (mknode (tb (quotient (sub1 n) 2)) (tb (quotient (sub1 n) 2)))]
    [true (mknode empty (tb (sub1 n)))]))

(define (help-node t) (mknode t t))

(define (tb2 n) ;; tree of size n
  (cond
    [(zero? n) empty]
    [(odd? n) (help-node (tb2 (quotient (sub1 n) 2)))]
    [true (mknode empty (tb2 (sub1 n)))]))