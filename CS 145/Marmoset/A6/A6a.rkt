#lang racket
(provide c x0 findx)

(define c 1)
(define x0 1)

;; f(x) = x, g(x) = 2*x
;; we need to show that f(x) =< c*g(x) for all x >= x0
;;   in other words, there does not exist x >= x0 such that
;;   f(x) > c*g(x)

;; we begin with a true inequality
;;    1 < 1*(2*1)
;;    x < 2*x   [for all x >= 1 (= x0)]
;;    f(x) < 1*g(x) [for all x >= 1 (= x0)]

;; Therefore (findx 1 1) must produce 'impossible, so f(x) is O(g(x))

(define (findx c x0)
  (cond
    [(> x0 (* c 2 x0)) x0]
    [else 'impossible]))