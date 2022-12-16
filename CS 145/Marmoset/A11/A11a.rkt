#lang lazy

;;Leaderboard Dr. Watson

(require "IOStream.rkt")
(require "Gen.rkt")

(define Nats
  (Gen
   0
   0
   (λ (inp state cont)
     (cont (add1 inp) 0 (list inp)))))

(define (Kill k s)
  (Gen
   s
   0
   (λ (inp state cont)
     (if (empty? inp)
         empty
         (if (= 0 (remainder (car inp) k))
             (cont (cdr inp) k empty)
             (cont (cdr inp) k (list (car inp))))))))

(define Y
  (lambda (f)
    ((lambda (self) (f (self self)))
     (lambda (self) (f (self self))))))

(define (prime? n)
  ((Y
   (λ (p?)
     (λ (n ps)
       (define curr (car (ps)))
       (if (> curr (sqrt n))
           true
           (if (= 0 (remainder n curr))
               false
               (p? n (λ () (cdr (ps))))))))) n (λ () primes)))

(define primes
  (Gen
   2
   1
   (λ (inp state cont)
     (cont (+ state inp) 2 (cond
                             [(= inp 2) (list 2)]
                             [(prime? inp) (list inp)]
                             [true empty])))))

(define twinprimes
  (Gen
   (car primes)
   (λ () (cdr primes))
   (λ (inp state cont)
     (define next (car (state)))
     (cont next (λ () (cdr (state))) (if (= 2 (- next inp)) (list (list inp next)) empty)))))