#lang racket

(define (explore-subtrie current-char subtrie-lst)
  (cond
    [(empty? subtrie-lst) 'rebuild-trie]
    [(char=? current-char (first (first subtrie-lst))) (cond
                                                         [(number? (second (first subtrie-lst))) (second (first subtrie-lst))]
                                                         [else (third (first subtrie-lst))])]
    [else
     (explore-subtrie current-char (rest subtrie-lst))]))

(define (iterate-chars subtrie-lst compressed-lst)
  (define current-char (peek-char))
  (cond
    [(or (char=? #\newline current-char) (eof-object? current-char)) (list->string (reverse compressed-lst)) (read-char)]
    [(or (char=? #\  current-char) (empty? compressed-lst)) ]
    [else
     (define subtrie-result (explore-subtrie current-char subtrie-lst))
     (cons (cond
             [(symbol=? 'rebuild-trie)