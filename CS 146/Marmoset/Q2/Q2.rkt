#lang racket

(define (check-lst word-count index word-lst)
  (cond
    [(not (number? index)) ""]
    [(= word-count index) (number->string index)]
    [(= (- word-count 1) index) (first word-lst)]
    [else (check-lst (- word-count 1) index (rest word-lst))]))

(define (iterate-chars word-count current-word-lst word-lst compressed-lst)
  (define current-char (read-char))
  (cond
    [(and (not (eof-object? current-char)) (or (char-alphabetic? current-char) (char-numeric? current-char))) (iterate-chars word-count (cons current-char current-word-lst) word-lst compressed-lst)]
    [else
     (if (char? current-char)
         (if (or (empty? current-word-lst) (char-numeric? (first current-word-lst)))
             (iterate-chars word-count empty word-lst (append (list current-char) (reverse (string->list (check-lst word-count (string->number (list->string (reverse current-word-lst))) word-lst))) compressed-lst))
             (iterate-chars (+ word-count 1) empty (cons (list->string (reverse current-word-lst)) word-lst) (append (list current-char) current-word-lst compressed-lst)))
         (display (list->string (reverse (append current-word-lst compressed-lst)))))]))

(iterate-chars 0 empty empty empty)