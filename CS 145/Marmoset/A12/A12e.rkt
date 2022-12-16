#lang racket

(require "cpu.rkt")
(require "RAM.rkt")

(define accum
                     '(18    ; [0]: first instruction
                       1     ; [1]: literal 1
                       2     ; [2]: literal 2
                       23    ; [3]: literal 23
                       50    ; [4]: literal 50
                       0     ; [5]: n
                       0     ; [6]: acc
                       1     ; [7]: unique n flag
                       0     ; [8]: n's so far
                       1     ; [9]: index
                       0     ; [10]: temp acc
                       0     ; [11]: literal 0
                       55    ; [12]: literal shift value
                       7     ; [13]: literal 7
                       0     ; [14]: 2nd temp acc
                       18    ; [15]: literal 18
                       3     ; [16]: literal 3
                       31    ; [17]: literal 31
                       80500 ; input n
                       40005 ; skip next if n = 0
                       00000 ; skip next
                       90000 ; halt
                       30017 ; skip to 31
                       40007 ; skip next if unique n flag = 0
                       10605 ; acc = acc + n
                       40007 ; skip next if unique n flag = 0
                       00800 ; increment n's so far
                       70006 ; out acc
                       30911 ; set index to 0
                       30701 ; set unique n's flag to 1
                       30015 ; go back to 18
                       31408 ; LOOP: set 2nd temp acc to n's so far
                       21409 ; sub index from 2nd temp acc
                       40014 ; skip next if 2nd temp acc = 0
                       00000 ; skip next
                       30004 ; END LOOP: skip to 50
                       31009 ; set temp acc to index
                       11012 ; add shift value to temp acc
                       51010 ; fetch element at index into temp acc
                       31405 ; set 2nd temp acc to n
                       21410 ; sub temp acc from 2nd temp acc
                       21005 ; sub n from temp acc
                       11014 ; add 2nd temp acc to temp acc
                       00900 ; increment index
                       40010 ; skip next if temp acc = 0
                       00000 ; skip next
                       00000 ; skip ahead 1
                       30017 ; REPEAT LOOP: go back to 31
                       30711 ; set unique n flag to 0
                       30003 ; END LOOP: go back to 23
                       31408 ; set 2nd temp acc to n's so far
                       11412 ; add literal shift value to 2nd temp acc
                       61405 ; store n in address pointed to by 2nd temp acc
                       70055 ;
                       30003 ; END LOOP: go back to 23
                       ))

(void (cpu (ram-load ram 0 accum) 0))