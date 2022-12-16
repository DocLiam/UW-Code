
(define (If tsts tru fls) (if tst tru fls))

(If false hello ((λ (x) (x x)) (λ (x) (x x))))

(define (f x y) (list y x y))

(length (f (+ 1 2) (+ 3 4)))

(define ones (cons 1 ones))
(car ones)
(cadr ones)
(list-ref ones 100000)

(define (make-fib cur nxt)