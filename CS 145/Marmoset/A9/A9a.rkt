#lang racket

(require "stream.rkt")

(provide stream-map)

(define (stream-map fn s)
  (stream-generate s stream-empty? stream-cdr (λ (x) (fn (stream-car x)))))