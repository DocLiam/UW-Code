;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-abbr-reader.ss" "lang")((modname A5a) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(define-struct node (left right key))

(define (take lst n)
  (cond
    [(= n 0) empty]
    [true (cons (car lst) (take (cdr lst) (- n 1)))]))

(define (drop lst n)
  (cond
    [(= n 0) lst]
    [true (drop (cdr lst) (- n 1))]))