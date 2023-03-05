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

(blist-to-nat (mult (list 3873 483 8476 4864 8411) (list 9013)))
(blist-to-nat (mult (list 7021 6276 6928 8736 3497 9602 3214 6224 6391 3286) (list 9978 1479 4576)))
(blist-to-nat (mult (list 8801) (list 8896 8938 7408 4549 4118)))
(blist-to-nat (mult (list 7786 5974 4946 6651 511 7187) (list 8752 7086 8348 5621 8714 9562 4215)))
(blist-to-nat (mult (list 3258 9570 6692 596 9220 3696 2877) (list 6759)))
(blist-to-nat (mult (list 6171 4566 6862 3160 3630 6240) (list 5263 2536 9713 3598 6255 9666 5967 6197 4891)))
(blist-to-nat (mult (list 4365 9859 4640 3667) (list 874 6702 1215 179 5874)))
(blist-to-nat (mult (list 2018 3526 5372 364 4454 7024 7932 1098 990) (list 1486 7832 9474 9362)))
(blist-to-nat (mult (list 8195 6810 9811 9833 9495 5256 443 6181) (list 863 7639 9808 8979 3806 3902 1168 3064 4286)))
(blist-to-nat (mult (list 5834 8488) (list 2432)))
(blist-to-nat (mult (list 8096 3639 3346 4518 3807 1444 3934 4637) (list 7295 8434 3298 5403 2586 6506 1037 1457 5994)))
(blist-to-nat (mult (list 668) (list 4940 3400 8900 2575)))
(blist-to-nat (mult (list 5077 9358 8562 6732 2355) (list 5826 3626 416 2274)))
(blist-to-nat (mult (list 7394 2538 759 9993 7319 5307 1160 2895 4632) (list 3798 6777 1811 6593 449 5348 8257 2906)))
(blist-to-nat (mult (list 6561 1009 6449 921 7399 3001 1599 5247 2661 3867) (list 8535 5989)))
(blist-to-nat (mult (list 92 2844 8758) (list 8269 6122)))
(blist-to-nat (mult (list 8762 9878 9597 5688 5986 8065 3636 8911 885) (list 7017 4180 43 1028)))
(blist-to-nat (mult (list 388 821 9549 4059) (list 5973 4437 868 5853 5587 9477 484 6102 3420 8978)))
(blist-to-nat (mult (list 7675 6991 5976 5922 8608) (list 1788 5480 879 5783 9097 6540)))
(blist-to-nat (mult (list 7659 8520 2778 8240 6393) (list 9125 9474 1297 5134 4339 3966 5020 4906 3889)))
(blist-to-nat (mult (list 8997 6436) (list 3757)))
(blist-to-nat (mult (list 8635 2312 343) (list 1894 8701 3426 6358 708 3851 6793)))
(blist-to-nat (mult (list 893 8736 1288 9443 4947 7552 7715 4382 1833) (list 9931 2072 3107 9571 3830 6986 5373 4191 4995 6760)))
(blist-to-nat (mult (list 6183 5345 5546) (list 4148 9291 6602 3345 6855)))
(blist-to-nat (mult (list 188 4781 313 5460 2366 4121 8397) (list 1052 771)))
(blist-to-nat (mult (list 1342 9597 306 7544 2799 8020) (list 9738 9462 3247 8689)))
(blist-to-nat (mult (list 8840 5862 657 9218 9581 240 8113 8328 3685 1031) (list 2879 5063 2096 5873 2533 3423 1039 3250)))
(blist-to-nat (mult (list 3405) (list 7017 9974 2481 6068 1917 2420 7370 8409)))
(blist-to-nat (mult (list 5996 3943 2046 8780 790 1143 6082) (list 6521 5112 9188 3252 9667 4242)))
(blist-to-nat (mult (list 434) (list 7644 498 1532)))