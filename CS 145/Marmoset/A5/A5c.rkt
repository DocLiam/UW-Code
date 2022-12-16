;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-abbr-reader.ss" "lang")((modname A5c) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(define-struct node (left right key))

(define (helper t lst)
  (cond
    [(empty? t) lst]
    [true (helper (node-left t) (cons (node-key t) (helper (node-right t) lst)))]))
     
(define (bst->list t)
  (helper t '()))