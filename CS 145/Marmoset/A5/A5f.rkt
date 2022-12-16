;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-abbr-reader.ss" "lang")((modname A5f) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(define-struct node (left right key))

(define (insert bst e)
  (cond
    [(empty? bst) (make-node empty empty e)]
    [(< e (node-key bst)) (make-node (insert (node-left bst) e) (node-right bst) (node-key bst))]
    [true (make-node (node-left bst) (insert (node-right bst) e) (node-key bst))]))

(define (iterate lst bst)
  (cond
    [(empty? lst) bst]
    [true (iterate (cdr lst) (insert bst (car lst)))]))

(define (rand->bst lst)
  (iterate lst '()))

(define (helper lst bst)
  (cond
    [(empty? bst) lst]
    [true (helper (cons (node-key bst) (helper lst (node-right bst))) (node-left bst))]))
     
(define (bst->list bst)
  (helper '() bst))

(define (get-lst lst i n)
  (cond
    [(= i n) lst]
    [true (get-lst (cdr lst) (add1 i) n)]))

(define (special-make-node lst a b shrunk-lst)
  (make-node (produce-balanced lst a (quotient (+ a b) 2)) (produce-balanced (cdr shrunk-lst) 0 (- b (add1 (quotient (+ a b) 2)))) (car shrunk-lst)))

(define (produce-balanced lst a b)
  (cond
    [(= a b) empty]
    [true (special-make-node lst a b (get-lst lst 0 (quotient (+ a b) 2)))]))
  
(define (helper2 lst)
  (produce-balanced lst 0 (length lst)))

(define (rand->balanced lst)
  (if (or (empty? lst) (empty? (car lst))) '() (helper2 (bst->list (rand->bst lst)))))