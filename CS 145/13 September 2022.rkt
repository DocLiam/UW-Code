;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname |13 September 2022|) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;math operations

(* 2 3 4)

(expt 2 32)

(sqrt 4)

(sqrt -4)

3/5

(quotient 5 2)

(remainder 5 2)

(modulo 5 2)

(sqrt 2)

(expt (sqrt 2) 2)

;truth values

(< 1 2)

(<= 1 2 2)

(>= 2 2 1)

;conditionals

(if true 123 456)

(if false 123 456)

(if (< 1 2) (+ (+ 1 2) 3) (+ (+ 4 5) 6))

;truth (boolean) expressions

(and true true true)

(and true false true)

(and (< 1 2) (< 3 4) (< 5 2) (< 6 7))

(number? 123)

(boolean? 123)

(boolean? false)

;symbols

(define foo 42)

(quote foo)
'foo

(symbol? foo)

(symbol? 'foo)

(number? foo)

;strings

(string? "hello world!")

;(+ 0 1 2 3 4 5 ... x) sum non-negative integers <= n

(define sumto0 0)

(define sumto1 1)

(define sumto2 3)

(define sumto3 6)

(define (sumto n)
  (if (= n 0) sumto0
      (if (= n 1) sumto1
          (if (= n 2) sumto2
              (if (= n 3) sumto3
                  (+ n (sumto (- n 1))))))))

(define (sumtonew n)
  (if (= n 0) sumto0
      (+ n (sumtonew (- n 1)))))

;sum integers from a to b and add c

(define (sumbetween a b c)
  (if (> a b) c
      (sumbetween (+ 1 a) b (+ a c))))

(sumbetween 0 10 0) ;sums integers >= 0, <= 10, plus  0

(define (newsumto n) (sumbetween 0 n 0))