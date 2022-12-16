#lang racket
; More fun with λ
; in ISL
; 2.5 new languages: 2 dialects of lazy racket; λ-calculus

; Racket expression whose evaluation never terminates
; ... without define or letrec

(define (forever) ((λ (x) (x x)) (λ (x) (x x))))

(if false (forever) 42)

(define (myif tst tru fls) (if tst tru fls))

; (myif false forever 42)

(define (sumto n) (if (zero? n) 0 (+ n (sumto (sub1 n)))))

; now withut define or letrec

(define (Sumto n) (if (zero? n) 0 (+ n (sumto (sub1 n)))))

(define (Sumto1 sumto n) (if (zero? n) 0 (+ n (sumto (sub1 n)))))

(define (Sumto2 self n) (if (zero? n) 0 (+ n (self self (sub1 n)))))

(define sss (λ (sumto)
              (λ (n)
                (if (zero? n) 0 (+ n (sumto (sub1 n)))))))

(define Y
  (λ (f)
    ((λ (self) (f (lambda (x) ((self self) x))))
     (λ (self) (f (lambda (x) ((self self) x)))))))