;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname A2a) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;Part k

(define (k n)
  (if (= n 0) 1 (* n (k (- n 1)))))

(define (step-count-k n)
  (+ 3 (* n 5)))

;When n is negative, the recursion never reaches base case n=0 because n continues decreasing
;When n is not an integer, the recursion never reaches base case n=0 because non-integer - 1 = non-integer

;Part l

(define (l n)
  (if (= n 0) 1 (* n (l (- n 1)) (l (- n 1)))))

(define (step-count-l n)
  (- (+ (expt 2 (+ n 3)) (expt 2 n)) 6))

;Part m

(define (m n)
  (if (= n 0) 1 (* n (m (quotient n 2)))))

(define (step-count-m n)
  (if (= n 0) 3 (+ 5 (step-count-m (quotient n 2)))))

;Part n

(define (step-count-n n)
  (if (= n 0) 3 (+ 5 (step-count-n (quotient n 2)))))

;Part o

(define (o n)
  (if (= n 0) 1 (* n (o (quotient n 2)) (o (quotient n 2)))))

(define (step-count-o n) 
  (if (= n 0) 3 (+ 6 (* 2 (step-count-o (quotient n 2))))))