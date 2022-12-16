;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname A1c) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;Part a

(+ 1 2 3 4 5 6 7 8)

(define step-count-a 1)

;Part b

(define step-count-b 1)

;Part c

(+ (+ (+ (+ (+ (+ (+ 1 2) 3) 4) 5) 6) 7) 8)

(define (step-count-c n) (- n 1))

;Part d

(+ (+ (+ 1 2) (+ 3 4)) (+ (+ 5 6) (+ 7 8)))

(define (step-count-d k) (- (expt 2 k) 1))

;Part e

(define property-e 'associative)