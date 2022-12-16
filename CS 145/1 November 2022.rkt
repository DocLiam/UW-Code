#lang scheme

(require "generate.rkt")
(require "stream.rkt")

(filter odd? (build-list 10 add1))

(define (myfilter f lst)
  (cond
    [(empty? lst) empty]
    [(f (car lst)) (cons (car lst) (myfilter f (cdr lst)))]
    [true (myfilter f (cdr lst))]))

(myfilter odd? (build-list 10 add1))

(define (myfiltertail f lst)
  (define (help L)
    (cond
      [(empty? L) empty]
      [(f (car L)) (help (car L) (cons (carr L) acc))]
      [true (help (cdr L) acc)]))
  (reverse (help lst empty)))
(myfiltertail odd? (build-list 10 add1))

(define (myfilterfoldl f lst)
  (foldl
   (lambda (e L) (if (f e) (cons e L) L))
   empty
   (reverse lst)))
(myfilterfoldl odd? (build-list 10 add1))

(define (myfilterfoldr f lst)
  (foldl
   (lambda (e L) (if (f e) (cons e L) L))
   empty
   lst))
(myfilterfoldr odd? (build-list 10 add1))

(define (myfiltergen f lst)
  (generate
   (list lst empty)
   (λ (x) (empty (car x)))
   (λ (x) (if (f (caar x)) (list (cdar x) (cons (caar x) (cadr x))) (list (cdar x) (cadr x))))
   (λ (x) (reverse (cadr x)))))

(define (myfilterstream f lst)
  (stream-generate
   (list lst empty)
   (λ (x) (empty (car x)))
   (λ (x) (if (f (caar x)) (list (cdar x) (cons (caar x) (cadr x))) (list (cdar x) (cadr x))))
   (λ (x) (reverse (cadr x)))))

(myfiltergen odd? (build-list 10 add1))