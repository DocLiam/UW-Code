#lang racket

(require "generate.rkt")

(define (special-fold f l order)
  (generate
   (list l '())
   (λ (x) (or (empty? (first x)) (empty? (rest (first x)))))
   (λ (x) (list (rest (rest (first x))) (cons (f (if (list? (second (first x))) (second (first x)) (cons (second (first x)) '())) (if (list? (first (first x))) (first (first x)) (cons (first (first x)) '())) order) (second x))))
   (λ (x) (if (empty? (first x)) (second x) (cons (first (first x)) (second x))))))

(define (insert-list a b)
  (generate
   (list a b)
   (λ (x) (empty? (first x)))
   (λ (x) (list (rest (first x)) (cons (first (first x)) (second x))))
   (λ (x) (second x))))

(define (my-sort-helper a b order)
  (generate
   (list a b '())
   (λ (x) (or (empty? (first x)) (empty? (second x))))
   (λ (x) (if (order (first (second x)) (first (first x)))
              (list (first x) (rest (second x)) (cons (first (second x)) (third x)))
              (list (rest (first x)) (second x) (cons (first (first x)) (third x)))))
   (λ (x) (cond
            [(not (empty? (first x))) (insert-list (third x) (first x))]
            [(not (empty? (second x))) (insert-list (third x) (second x))]
            [true (third x)]))))

(define (find-diff l order)
  (generate
   (list l (first l))
   (λ (x) (empty? (first x)))
   (λ (x) (if (equal? (first (first x)) (second x)) (list (rest (first x)) (second x)) (list '() (first (first x)))))
   (λ (x) (not (or (order (first l) (second x)) (order (second x) (first l)))))))

(define (my-sort l order)
  (generate
   (list l 0)
   (λ (x) (or (equal? (second x) true) (empty? (first x)) (empty? (rest (first x)))))
   (λ (x) (list (special-fold my-sort-helper (first x) order) (if (real? (second x)) (find-diff (first x) order) false)))
   (λ (x) (if (second x) l (if (empty? (first x)) '() (if (list? (first (first x))) (first (first x)) (first x)))))))
