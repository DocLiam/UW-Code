;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname A3a) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(define-struct thing (a b))
(define u (make-thing 1 2))
(define v (make-thing (make-thing (make-thing 1 2) (make-thing 3 4))  
                      (make-thing (make-thing 5 6) (make-thing 7 8))))
(define w (make-thing 
           (make-thing 
            (make-thing 
             (make-thing 
              (make-thing 
               (make-thing 
                (make-thing 1 2) 3) 4) 5) 6) 7) 8))

; Part u

;(define (sum-thing t)
;  (+ (thing-a t) (thing-b t)))

; Part v

;(define (sum-thing t)
;  (cond
;    [(thing? t) (+ (thing-a t) (thing-b t))]
;    [true t]))

; Part w

;(define (sum-thing t)
;  (cond
;    [(and (thing? t) (or (thing? (thing-a t)) (thing? (thing-b t)))) (+ (sum-thing (thing-a t)) (sum-thing (thing-b t)))]
;    [(thing? t) (+ (thing-a t) (thing-b t))]
;    [true t]))

; Part w (simpler)

(define (sum-thing t)
  (cond
    [(thing? t) (+ (sum-thing (thing-a t)) (sum-thing (thing-b t)))]
    [true t]))

; Part x

(define (build-thing m n)
  (cond
    [(> n m) (make-thing (build-thing m (- n 1)) n)]
    [true n]))

; Part y

(define (helper-build-thing-or-number a b)
  (cond
    [(= (- b a) 1) (make-thing a b)]
    [true (make-thing (helper-build-thing-or-number a (- (/ (+ a b 1) 2) 1)) (helper-build-thing-or-number (/ (+ a b 1) 2) b))]))

(define (build-thing-or-number n)
  (cond
    [(> n 1) (helper-build-thing-or-number 1 n)]
    [true 1]))

; If the assumption n=2^k for k being a non-negative integer was false, it would be sensible to produce the same "thing" using n^k with k rounded up, and fill the numbers > n with empty values.
