#lang racket

(define-struct blist (lst))

(define (blist-to-nat-helper blist nat i)
  (cond
    [(empty? blist) nat]
    [else
     (blist-to-nat-helper (rest blist) (+ nat (* (first blist) (expt 10000 i))) (+ i 1))]))

(define (blist-to-nat blist)
  (blist-to-nat-helper blist 0 0))

(define (log-nat nat i)
  (cond
    [(= (quotient nat 10000) 0) i]
    [else
     (log-nat (quotient nat 10000) (+ i 1))]))

(define (nat-to-blist-helper nat blist)
  (cond
    [(= (log-nat nat 0) 0) (cons nat blist)]
    [else
     (nat-to-blist-helper (modulo nat (expt 10000 (log-nat nat 0))) (cons (quotient nat (expt 10000 (log-nat nat 0))) blist))]))

(define (nat-to-blist nat)
  (cond
    [(= nat 0) empty]
    [else
     (nat-to-blist-helper nat empty)]))

(define (continue-add blist blist3 carry)
  (cond
    [(empty? blist) (if (> carry 0) (cons carry blist3) blist3)]
    [else
     (continue-add (rest blist) (cons (modulo (+ (first blist) carry) 10000) blist3) (quotient (+ (first blist) carry) 10000))]))

(define (add-helper blist1 blist2 blist3 carry)
  (cond
    [(empty? blist1) (continue-add blist2 blist3 carry)]
    [(empty? blist2) (continue-add blist1 blist3 carry)]
    [else
     (add-helper (rest blist1) (rest blist2) (cons (modulo (+ (first blist1) (first blist2) carry) 10000) blist3) (quotient (+ (first blist1) (first blist2) carry) 10000))]))

(define (add blist1 blist2)
  (reverse (add-helper blist1 blist2 empty 0)))

(define (mult-helper2 bigit blist2 blist3)
  (cond
    [(empty? blist2) empty]
    [(empty? blist3) (cons (* bigit (first blist2)) (mult-helper2 bigit (rest blist2) empty))]
    [else
     (cons (+ (* bigit (first blist2)) (first blist3)) (mult-helper2 bigit (rest blist2) (rest blist3)))]))

(define (mult-helper blist1 blist2 blist3)
  (cond
    [(empty? blist1) blist3]
    [else
     (define current-sum (mult-helper2 (first blist1) blist2 blist3))
     (cons (first current-sum) (mult-helper (rest blist1) blist2 (rest current-sum)))]))

(define (mult blist1 blist2)
  (cond
    [(or (empty? blist1) (empty? blist2)) empty]
    [else
     (add (mult-helper blist1 blist2 empty) empty)]))