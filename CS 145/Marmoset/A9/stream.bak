#lang racket

;; Stream implementation v1.1
;; Copyright 2010 Gordon V. Cormack
;; Permission is granted for student use
;; is cs145, Fall 2010
;; Publication or other use prohibited

(provide stream-car stream-cdr stream-cons 
  stream-empty stream-empty? stream-generate list->stream
  stream->list)

(define-struct stream-pair (this next))
(define (stream-car s) (stream-pair-this s))
(define (stream-cdr s) ((stream-pair-next s)))
(define (stream-cons e s) (make-stream-pair e (lambda () s)))
(define stream-empty empty)
(define stream-empty? empty?)

(define (stream-generate first done? step final)
  (cond
    [(done? first) empty]
    [else (make-stream-pair
           (final first)
           (lambda ()
             (stream-generate
              (step first)
              done?
              step
              final)))]))

(define (list->stream l) (foldr stream-cons stream-empty l))

(define (stream->list s)
  (if (stream-empty? s) empty (cons (stream-car s) (stream->list (stream-cdr s)))))