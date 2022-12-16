;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-abbr-reader.ss" "lang")((modname A5e) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(define-struct node (left right key))

(define (insert bst e)
  (cond
    [(empty? bst) (make-node empty empty e)]
    [(< e (node-key bst)) (make-node (insert (node-left bst) e) (node-right bst) (node-key bst))]
    [true (make-node (node-left bst) (insert (node-right bst) e) (node-key bst))]))

(define (get-lst lst i n)
  (cond
    [(= i n) lst]
    [true (get-lst (cdr lst) (add1 i) n)]))

(define (special-make-node lst bst a b shrunk-lst)
  (produce-balanced (cdr shrunk-lst) (produce-balanced lst (insert bst (car shrunk-lst)) a (quotient (+ a b) 2)) 0 (- b (add1 (quotient (+ a b) 2)))))

(define (produce-balanced lst bst a b)
  (cond
    [(= a b) bst]
    [true (special-make-node lst bst a b (get-lst lst 0 (quotient (+ a b) 2)))]))
  
(define (rand->bst lst)
  (if (or (empty? lst) (empty? (car lst))) '() (produce-balanced lst '() 0 (length lst))))