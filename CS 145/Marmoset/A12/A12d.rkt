#lang racket

(require "cpu.rkt")
(require "RAM.rkt")

(define accum
  '(6     ; [0]: first instruction
    1     ; [1]: literal 1
    2     ; [2]: literal 2
    7     ; [3]: literal 7
    0     ; [4]: n
    0     ; [5]: acc
    80400 ; input n
    40004 ; skip next if n = 0
    10001 ; skip next instruction
    90000 ; halt
    10504 ; acc = acc + n
    70005 ; out acc
    20003 ; go back 7 (from next instr)
    ))