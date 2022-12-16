#lang racket
(provide findx c x0)

(define c 2)
(define x0 1)

(define (findx c x0)
  (cond
    [(< c 2) x0]
    [true 'impossible]))

;; First we solve f(a) = c*g(a)
;;   2^a = c*2^(a-1)
;;   c = 2
;;
;;   So for all x where c = 2, f(x) = c*g(x) and therefore (findx c x0) must return 'impossible
;;
;; Now take c < 2
;;   2^x > c*2^(x-1)   [for all x]
;;
;;   So for all x where c < 2, f(x) > c*g(x) and therefore any x0 in (findx c x0) is valid and we return x0
;;
;; Now take c > 2
;;   2^x < c*2^(x-1)   [for all x]
;;
;;   So for all x where c > 2, f(x) < c*g(x) and therefore (findx c x0) must return 'impossible