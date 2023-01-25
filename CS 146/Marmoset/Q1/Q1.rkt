#lang racket

(define (check-lst word-count current-word word-lst)
  (cond
    [(empty? word-lst) -1]
    [(string=? current-word (first word-lst)) (- word-count 1)]
    [else (check-lst (- word-count 1) current-word (rest word-lst))]))

(define (iterate-chars word-count current-word-lst word-lst compressed-lst)
  (define current-char (read-char))
  (cond
    [(and (not (eof-object? current-char)) (char-alphabetic? current-char)) (iterate-chars word-count (cons current-char current-word-lst) word-lst compressed-lst)]
    [else
     (define index (if (empty? current-word-lst) 0 (check-lst word-count (list->string (reverse current-word-lst)) word-lst)))
     (define new-current-word-lst
       (cond
         [(or (= index -1) (empty? current-word-lst)) current-word-lst]
         [else
          (reverse (string->list (number->string index)))]))
     (if (char? current-char)
         (iterate-chars (if (= index -1) (+ word-count 1) word-count) empty (if (= index -1) (cons (list->string (reverse new-current-word-lst)) word-lst) word-lst) (append (list current-char) new-current-word-lst compressed-lst))
         (display (list->string (reverse (append new-current-word-lst compressed-lst)))))]))

(iterate-chars 0 empty empty empty)