#lang racket
(define-struct foo (a b) #:transparent) ;; use transparent to behave like student languages

(define x (foo 'homer 'bart))
(define y (foo 'homer 'bart))

;; No built-in way of checking if structs are equal - not part of our definition
