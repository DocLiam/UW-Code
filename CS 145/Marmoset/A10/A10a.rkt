#lang lazy
(lambda(a b)((a ((b (lambda(x)(lambda(y)y))) (lambda(x)(lambda(y)x)))) b))