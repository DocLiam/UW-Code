#lang racket

(provide generate)

(define (generate first done? step final)
  (define (gen first)
    (if (done? first) (final first) (gen (step first))))
  (gen first))