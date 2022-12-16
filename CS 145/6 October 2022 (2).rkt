;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname |6 October 2022 (2)|) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(define (old-foo x)
  (if (zero? x) 1 (+ (old-foo (sub1 x)) (old-foo (sub1 x)) (old-foo (sub1 x)))))

(define (foo x)
  (if (zero? x) 1 ((lambda (w) (+ w w w))(foo (sub1 x))))) ; where w = (foo (sub1 x))

; lisp/scheme/racket equivalent

(define (Foo x)
  (if (zero? x) 1
      (letrec
          ([w (Foo (sub1 x))]
           [zz 0]
           [foofoo (lambda (x) (if (zero? x) 0 (foofoo (sub1 x))))])
          (+ zz w w w))))

; (build-list n xxx) is a list with n elements formed by applying xxx to 0,1,2,...,n-1

(build-list 10 (lambda (x) (random 10)))

(foldl (lambda (x y) (- x y)) 1 (build-list 10 add1))
(foldr (lambda (x y) (- x y)) 1 (build-list 10 add1))

(map sqr (build-list 10 add1))