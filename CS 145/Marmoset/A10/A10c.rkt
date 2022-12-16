#lang lazy

(require "Lambda.rkt")

(define (XOR a b)
  ((a ((b (lambda(x)(lambda(y)y))) (lambda(x)(lambda(y)x)))) b))

(define (AND a b)
  ((a b)(lambda(x)(lambda(y)y))))

(define (OR a b)
  ((a (lambda(x)(lambda(y)x))) b))

(define (SUB-HELP sub new-c d)
  (Cons (Car new-c) (sub (Cdr new-c) (Cdr d))))

(define (SUB a b)
  ((Y
    (λ (sub)
      (λ (c d)
        (If (Z? d)
            c
            (SUB-HELP sub (((Car d) (SUB1 c)) c) d))))) a b))

(define (SUB1 a)
  ((Y
    (λ (sub1)
      (λ (num)
        (((Car num)
            (If (Z? (Cdr num))
                Z
                (Cons False (Cdr num))))
            (Cons True (sub1 (Cdr num))))))) a))

(define (LENGTH a)
  ((Y
    (λ (length)
      (λ (num len)
        (If (Z? num)
            len
            (length (Cdr num) (ADD1 len)))))) a Z))

(define (PACKAGE c a)
  (Cons (Cons c (Car a)) (Cdr a)))

(define (SPLIT a n)
  ((Y
    (λ (split)
      (λ (num i)
        (If (Z? i)
            (Cons Empty num)
            (PACKAGE (Car num) (split (Cdr num) (SUB1 i))))))) a n))

(define (PAD a n)
  ((Y
    (λ (pad)
      (λ (num i)
        (If (Z? i)
            num
            (Cons False (pad num (SUB1 i))))))) a n))

(define (KARATSUBA mul n xhyh xlyl xh xl yh yl)
  (ADD (ADD (PAD xhyh n) xlyl) (PAD (SUB (SUB (mul (ADD xh xl) (ADD yh yl)) xhyh) xlyl) (Cdr n))))

(define (HANDLER mul xn yn x y)
  (define xsplit (SPLIT x (Cdr xn)))
  (define xh (Cdr xsplit))
  (define xl (Car xsplit))
  (define ysplit (SPLIT y (Cdr yn)))
  (define yh (Cdr ysplit))
  (define yl (Car ysplit))
  (KARATSUBA mul (ADD (Cdr xn) (Cdr yn)) (mul xh yh) (mul xl yl) xh xl yh yl))

(define (MUL a b)
  ((Y
    (λ (mul)
      (λ (c d)
        (If (Z? c)
            Z
            (If (Z? d)
                Z
                (If (Z? (Cdr c))
                    (((Car c) d) Z)
                    (If (Z? (Cdr d))
                        (((Car d) c) Z)
                        (HANDLER mul (LENGTH c) (LENGTH d) c d)))))))) a b))