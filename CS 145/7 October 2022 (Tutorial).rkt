#lang racket

(define (tree-count n)
  (cond
    [(zero? n) 1]
    [true
     (define prevs (build-list n tree-count))
     (foldl + 0 (map * prevs (reverse prevs)))]))

(define (tree-count-acc n)
  ; takes a list of first k catalan numbers
  ; produces list of the first k+1 catalan numbers
  (define (helper acc)
    (cond (foldl + 0 (map * acc (reverse acc)))
          acc))
  (define (gen acc)
    (if (= (length acc) (add1 n)) (car acc)
        (gen (helper acc))))
  (gen '(1)))

(define exprs (port->list))

(define (count-trans expr)
  (cond [(not (list? expr)) expr]
        [(and (symbol=? 'define (car expr)) (list? cadr expr))
         (define ,(cadr expr)
           (set! _CNT 