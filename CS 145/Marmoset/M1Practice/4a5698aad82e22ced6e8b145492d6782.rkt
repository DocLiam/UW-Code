;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname 4a5698aad82e22ced6e8b145492d6782) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname b02e165c098250121d9e3c8a85082f93) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;; CS145 First Midterm test for lrwatson

;; Start time: 2022-09-27T10:10:20-04:00
;; Time limit: 2 hours

;; Question 1 [5 marks]  Replace ... in the definition below so that (foo x)
;; calculates the sum of the non-negative integers less than x.  If you wish,
;; you may provide additional explanation as text in Explain1.

(define (foo x)
  
  (if (= x 0) 0 (+ (- x 1) (foo (- x 1))))
  
  )

(define Explain1 "

  We recursively call foo with x less by 1 each time and add the current x minus 1 each time until it reaches a base case x = 0. This returns the sum of all non-negative integers less than x.

")

;; Question 2 [5 marks]  Replace ... in the definition below so that
;; (floorlog2 x) calculates exactly the floor of the base-2 logarithm
;; of a positive integer x.  In Explain2, prove that your solution is
;; correct.

(define (floorlog2 x)

     (floor (log 2 x))
  
  )

(define Explain2 "

   floor is a built-in exact value function, and takes the result of the exact value function log, which takes 2 as the base and x as the result, returning the exponent. Since log is performed first, floor floors the value afterwards, proving that it does in fact calculate the exact floor of the base-2 logarithm of positive x.

")

;; Question 3 [2 marks]  How many min-height trees are there with four
;; elements?  Explain if you wish.

(define Answer3 "

   Every min-height tree with 2^n-1 nodes where n is a non-negative integer is a perfect tree, since it fills every possible node opening without breaching the minimum height.
   Since 4 is a power of 2, it means that the number of dissimilar min-height trees can be calculated with 3 of the nodes as a perfect tree, and 1 excess node placed in other openenings.
   The excess node can be a leaf of eiher 2 current leaf nodes (for a 3 node tree), which implies 4 possible positions. Beyond that, it can also be the root of the 3 node tree, with the sub tree in either the left or right opening (2 more possibilities).
   This means the total number of min-height trees with 4 elements is 4+2 = 6.


")