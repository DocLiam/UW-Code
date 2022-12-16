#lang lazy

;;Leaderboard Dr. Watson

(require "IOStream.rkt")
(require "Gen.rkt")

(define (RPS Player1 Player2)
      (define A (Player1 (history B)))
      (define B (Player2 (history A)))
      (playgame A B))

(define (randomplay h)(rps))

(define (const move)
  (cons move (const move)))

(define (bart opponent-history)
  (const 'rock))

(define (lisa opponent-history)
  (const 'paper))

(define (maggie opponent-history)
  (cons 'paper (const (oppose (caaar (RPS (λ (x) (cdr opponent-history)) bart))))))

(define (sum p)
  (+ (car p) (cadr p) (caddr p)))

(define (norm p s)
  (list (/ (car p) s) (/ (cadr p) s) (/ (caddr p) s)))

(define (probability s n p)
  (cond
    [(= n 0) (norm p (sum p))]
    [true (probability (cdr s)
                       (sub1 n)
                       (cond
                         [(eq? 'rock (car s)) (list (+ (car p) (exp n)) (cadr p) (caddr p))]
                         [(eq? 'paper (car s)) (list (car p) (+ (cadr p) (exp n)) (caddr p))]
                         [true (list (car p) (cadr p) (+ (caddr p) (exp n)))]))]))

(define (oppose move)
  (cond
    [(eq? 'rock move) 'paper]
    [(eq? 'paper move) 'scissors]
    [true 'rock]))

(define (inc lst move)
  (cond
    [(eq? 'rock move) (list (add1 (car lst)) (cadr lst) (caddr lst))]
    [(eq? 'paper move) (list (car lst) (add1 (cadr lst)) (caddr lst))]
    [true (list (car lst) (cadr lst) (add1 (caddr lst)))]))

(define (get-move max lst)
  (if (= max (car lst))
      'rock
      (if (= max (cadr lst))
          'paper
          'scissors)))

(define (get-max lst)
  (max (car lst) (cadr lst) (caddr lst)))

(define (champion opponent-history)
  (cons 'paper
        (Gen
         (list '(0 0 0) '(0 0 0) '(0 0 0))
         1
         (λ (inp state cont)
           (define relevant (list-ref opponent-history state))
           (define new-inp (if (> state 1)
               (cond
                 [(eq? 'rock (cadr relevant)) (list (inc (car inp) (car relevant)) (cadr inp) (caddr inp))]
                 [(eq? 'paper (cadr relevant)) (list (car inp) (inc (cadr inp) (car relevant)) (caddr inp))]
                 [true (car inp) (list (car inp) (cadr inp) (inc (caddr inp) (car relevant)))])
               inp))
           (cont new-inp (add1 state) (list (oppose (cond
                                                      [(eq? 'rock (car relevant)) (get-move (get-max (car new-inp)) (car new-inp))]
                                                      [(eq? 'paper (car relevant)) (get-move (get-max (cadr new-inp)) (cadr new-inp))]
                                                      [true (get-move (get-max (caddr new-inp)) (caddr new-inp))]))))))))