#lang lazy

(require "IOStream.rkt")
(require "Gen.rkt")

(define fred (cons 'fred wilma))
(define wilma (cons 'wilma fred))

(define (fib-gen cur nxt)
  (cons cur (fib-gen nxt (+ cur nxt))))

(define fibs (fib-gen 0 1))
