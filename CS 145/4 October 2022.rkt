;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-abbr-reader.ss" "lang")((modname |4 October 2022|) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(random 10)
(random 10)
(random 10)

(require racket/base)

(define (bild n m) ; list of n elements, each between 0 and m-1, inclusive
  (cond
    [(zero? n) empty]
    [true (cons (random m) (bild (sub1 n) m))]))

;(define x (bild 20000 100000000))
(define x (list 10 20 30 40))

(define (badrev lst)
  (cond
    [(empty? lst) empty]
    [true (append (badrev (cdr lst)) (list (car lst)))]))

;(time (length (badrev x)))
;(time (length (reverse x)))

(define (insorder e lst) ; insert into ordered list (with potential duplicates)
  (cond
    [(empty? lst) (list e)]
    [(< e (car lst) (insorder e (cdr lst)))]
    [true (cons (car lst) (insorder e (cdr lst)))]))

(define (insordset e lst) ; insert into increasing ordered list (no duplicates allowed)
  (cond
    [(empty? lst) (list e)]
    [(< e (car lst)) (cons e lst)]
    [(< (car lst) e) (cons (car lst) (insordset e (cdr lst)))]
    [true lst]))

(define (makeordered lst)
  (cond
    [(empty? lst) empty]
    