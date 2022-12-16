#lang lazy

(require "IOStream.rkt")

(define x (take 5 instream))

(length x)

(foldl + 0 instream)