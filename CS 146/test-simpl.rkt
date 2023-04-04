#lang racket
 
(require "simpl.rkt")
 
(vars ([m 7777] [n 88888] [i 10] [j 1] [temp_i 0] [reversed_i 0] [perfect true])
      (while (<= i n)
             (set perfect true)
             (set temp_i i)
             (set reversed_i 0)
             (while (not (= temp_i 0))
                    (set reversed_i (+ (* reversed_i 10) (mod temp_i 10)))
                    (set temp_i (div temp_i 10)))
             (iif (not (= i reversed_i))
                 (skip)
                 (seq
                  (set j 2)
                  (while (<= (* j j) i)
                         (iif (= (mod i (* j j)) 0)
                             (seq (set perfect false) (set j i))
                             (skip))
                         (set j (+ j 1)))
                  (iif perfect
                      (seq (print i) (print "\n"))
                      (skip))))
              (set i (+ i 1))))