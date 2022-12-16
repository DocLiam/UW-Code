;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname A2b) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(define (fib n) (if (< n 2) n (+ (fib (- n 1)) (fib (- n 2)))))

(define (step-count-fib n) (if (< n 2) 3 (if (= n 2) 12 (+ (* (- n 2) 9) (step-count-fib (- n 1))))))

(define (step-count-k n)
  (+ 3 (* n 5)))

(define (step-count-l n)
  (- (+ (expt 2 (+ n 3)) (expt 2 n)) 6))

(define (step-count-m n)
  (if (= n 0) 3 (+ 5 (step-count-m (quotient n 2)))))

(define (step-count-o n) 
  (if (= n 0) 3 (+ 6 (* 2 (step-count-o (quotient n 2))))))

; Part p

(define (compare-steps-k n) (if (< (step-count-fib n) (step-count-k n)) 'fewer (if (> (step-count-fib n) (step-count-k n)) 'more 'same)))

; Part q

(define (compare-steps-l n) (if (< (step-count-fib n) (step-count-l n)) 'fewer (if (> (step-count-fib n) (step-count-l n)) 'more 'same)))

; Part r

(define (compare-steps-m n) (if (< (step-count-fib n) (step-count-m n)) 'fewer (if (> (step-count-fib n) (step-count-m n)) 'more 'same)))

; Part s

(define (compare-steps-o n) (if (< (step-count-fib n) (step-count-o n)) 'fewer (if (> (step-count-fib n) (step-count-o n)) 'more 'same)))

; Part t

(define (nextfib a b n) (if (= n 0) a (nextfib b (+ a b) (- n 1))))
(define (fib1 n) (nextfib 0 1 n))

(define (step-count-t n) (if (= n 0) 4 (+ 5 (step-count-t (- n 1)))))