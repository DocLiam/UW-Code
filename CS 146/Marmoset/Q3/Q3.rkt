#lang racket

(define (check-valid expr-lst operand-count operator-count)
  (cond
    [(empty? expr-lst) (or (and (= operand-count 0) (= operator-count 0)) (= (- operand-count 1) operator-count))]
    [else
     (cond
       [(list? (first expr-lst)) (and (check-valid (first expr-lst) 0 0) (check-valid (rest expr-lst) (+ operand-count 1) operator-count))]
       [(not (or (list? (first expr-lst)) (eq? (first expr-lst) '+) (eq? (first expr-lst) '*))) (number? (first expr-lst)) (and (= operand-count operator-count) (check-valid (rest expr-lst) (+ operand-count 1) operator-count))]
       [(or (symbol=? (first expr-lst) '+) (symbol=? (first expr-lst) '*)) (and (= (- operand-count 1) operator-count) (check-valid (rest expr-lst) operand-count (+ operator-count 1)))]
       [else false])]))

(define (collapse-brackets expr-lst acc)
  (cond
    [(empty? expr-lst) (if (and (not (empty? acc)) (list? (first acc)) (= (length acc) 1)) (first acc) acc)]
    [(not (list? (first expr-lst))) (collapse-brackets (rest expr-lst) (append acc (list (first expr-lst))))]
    [else
     (cond
       [(= (length (first expr-lst)) 1) (collapse-brackets (rest expr-lst) (append acc (collapse-brackets (first expr-lst) empty)))]
       [else
        (collapse-brackets (rest expr-lst) (append acc (list (collapse-brackets (first expr-lst) empty))))])]))

(define (total-order a b)
  (cond
    [(list? a) (if (number? b) false true)]
    [else (if (list? b) true (<= a b))]))

(define (product-helper expr-lst complete-expr-lst product-lst)
  (cond
    [(= (length expr-lst) 1) (add-helper empty (append complete-expr-lst (list (append (list '*) product-lst (list (add-helper (first expr-lst) empty))))))]
    [(symbol=? (second expr-lst) '+) (add-helper (rest (rest expr-lst)) (append complete-expr-lst (list (append (list '*) product-lst (list (add-helper (first expr-lst) empty))))))]
    [else
     (product-helper (rest (rest expr-lst)) complete-expr-lst (append product-lst (list (add-helper (first expr-lst) empty))))]))

(define (add-helper expr-lst complete-expr-lst)
  (cond
    [(not (or (list? expr-lst) (eq? expr-lst '+) (eq? expr-lst '*))) expr-lst]
    [(empty? expr-lst) (if (= (length complete-expr-lst) 1) (first complete-expr-lst) (if (empty? complete-expr-lst) empty (append (list '+) complete-expr-lst)))]
    [(= (length expr-lst) 1) (if (> (length complete-expr-lst) 0) (append (list '+) complete-expr-lst (list (add-helper (first expr-lst) empty))) (first expr-lst))]
    [(symbol=? (second expr-lst) '*) (product-helper expr-lst complete-expr-lst empty)]
    [else
     (add-helper (rest (rest expr-lst)) (append complete-expr-lst (list (add-helper (first expr-lst) empty))))]))

(define (in->pre expr-lst)
  (cond
    [(not (or (list? expr-lst) (eq? expr-lst '+) (eq? expr-lst '*))) expr-lst]
    [else
     (if (not (check-valid expr-lst 0 0))
         (error "bad expression")
         (add-helper (collapse-brackets expr-lst empty) empty))]))