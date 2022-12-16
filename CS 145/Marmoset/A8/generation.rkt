#lang racket

(require "generate.rkt")

(define (prime? n)
  (generate
   (list 2)
   (λ (x) (or (= (/ n (first x)) (quotient n (first x)))(>= (first x) (sqrt n))))
   (λ (x) (list (+ (first x) 1)))
   (λ (x) (and (> n 1) (or (= n 2) (not (= (/ n (first x)) (quotient n (first x)))))))))

(define (my-build-list n f)
  (generate
   (cons (sub1 n) (list))
   (λ (x) (= (first x) -1))
   (λ (x) (cons (sub1 (car x)) (append (list (f (car x))) (cdr x))))
   (λ (x) (cdr x))))

(define (my-foldl f z l)
  (generate
   (list z l)
   (λ (x) (empty? (second x)))
   (λ (x) (list (f (first (second x)) (first x)) (rest (second x))))
   (λ (x) (first x))))

(define (my-insert e l order)
  (generate
   (list '() l false)
   (λ (x) (empty? (second x)))
   (λ (x) (if (and (not (third x)) (order e (first (second x)))) (list (cons (first (second x)) (cons e (first x))) (rest (second x)) true) (list (cons (first (second x)) (first x)) (rest (second x)) (third x))))
   (λ (x) (reverse (if (third x) (first x) (cons e (first x)))))))

(define (my-insertion-sort l order)
  (generate
   (list '() l)
   (λ (x) (empty? (second x)))
   (λ (x) (list (my-insert (first (second x)) (first x) order) (rest (second x))))
   (λ (x) (first x))))