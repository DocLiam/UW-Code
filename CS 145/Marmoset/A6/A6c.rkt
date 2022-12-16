#lang racket
(provide c x0 findx)

(define c 1)
(define x0 10)

;; f(x)=x, g(x)=100*floor(x/10)
;; we need to show that f(x) =< c*g(x) for all x >= x0
;;   in other words, there does not exist x >= x0 such that
;;   f(x) > c*g(x)
;;
;; we begin with a true inequality
;;    10 < 1*(100*floor(10/10))
;;    x < 100*floor(x/10)   [for all x >= 10 (= x0)]
;;    f(x) < 1*g(x) [for all x >= 10 (= x0)]
;;
;; Therefore (findx 1 10) must produce 'impossible, so f(x) is O(g(x))

(define (findx c x0)
  (cond
    [(< (* c 100 (floor (/ x0 10))) x0) x0]
    [(< (* c 100 (floor (/ x0 10))) (- (* (floor (/ (+ x0 10) 10)) 10) 1)) (- (* (floor (/ (+ x0 10) 10)) 10) 1)]
    [(< c 1/10) 1]
    [true 'impossible]))

;; We know that for case 1, if f(x0) > c*g(x0) then we can simply return x = x0 since x >= x0
;;
;; We know that if case 1 is not true, it means that x0 should be rounded up to the nearest x multiple of 10 such that x > x0, and 1 subtracted from it so that we can check if this value f(x) is greater than c*g(x) (= c*g(x0) <- since x is floored to the same value as x0)
;;
;; We know that if case 2 is also not true, then the only way for a value x >= x0 to satisfy f(x) > c*g(x) is for c < 0.1 since that means the gradient of the "steps" of c*g(x) is less than 1, and the only calues satisfying this are x0 < 0, therefore x can take any value >= 0, so we choose 1
;;
;; Finally, we know that if case 3 is also not true, then all values of c*g(x) > f(x) for x >= x0, since the gradient of the "steps" of c*g(c) is greater than 1, and so x does not exist -> we return 'impossible