#lang racket
(provide findx c x0)

(define c 'noneT)
(define x0 'none)

(define (findx c x0)
  (ceiling (max (* c c) x0)))

;; First solve f(a) = c*g(a)
;;   a = c*a^0.5
;;   a^0.5 = c
;;   a = c^2
;;
;; Now pick any x > c^2:
;;   x > c*x^0.5   [provided x > c^2]
;;
;; Also, we must have x >= x0, so pick
;;
;;      x = max(c+1, x0)
;;
;; Since (findx c x0) produces x for all c,x0
;;  we conclude that f(x) is not O(g(x))