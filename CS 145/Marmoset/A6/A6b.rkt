#lang racket
(provide c x0 findx)

(define c 3000000)
(define x0 1)

;; f(x) = 2*x+1, g(x) = x/1000000
;; we need to show that f(x) =< c*g(x) for all x >= x0
;;   in other words, there does not exist x >= x0 such that
;;   f(x) > c*g(x)

;; we begin with a true inequality
;;    2*1+1 =< 3000000*(1/1000000)
;;    2x+1 =< 3*x   [for all x >= 1 (= x0)]
;;    f(x) =< 3000000*g(x) [for all x >= 1 (= x0)]

;; Therefore (findx 3000000 1) must produce 'impossible, so f(x) is O(g(x))

(define (findx c x0)
  (cond
    [(> (+ (* 2 x0) 1) (/ (* c x0) 1000000)) x0]
    [else 'impossible]))