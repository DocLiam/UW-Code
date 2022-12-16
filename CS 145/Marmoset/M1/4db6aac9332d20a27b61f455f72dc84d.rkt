;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname 4db6aac9332d20a27b61f455f72dc84d) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;;  CS145 First Midterm Test for lrwatson

;;  Time limit: 1 hour 50 minutes (110 minutes)
;;  Start time: October 3, 7:00 p.m.
;;  End time:   October 3, 8:50 p.m.
;;  Total marks: 30 [suggested time 3 minutes per mark + 20 reserve]

;;  Racket and Racket Help permitted                            
;;  Pencil, pen and (supplied) blank paper permitted                            
;;  No other aids permitted                            

;;  Answer all questions                            

;;  You may use helper functions as you wish                            
;;  Explanations may be provided as comments                            

; Question 1 [4 parts X 5 marks = 20 marks]                            

; Consider the function foo below.                            

(define (foo x)
  (if (zero? x) 1
      (+ (sqrt (foo (sub1 x)))(foo (sub1 x)) (/ 1 (foo(sub1 x))))))

; (a) [5 marks] Complete the function (foosteps x) below by replacing ...                            
; to compute the number of steps reqired to evaluate (foo x), for any non-negative                            
; integer x.  The running time to evaluate (foosteps 10000) should                            
; be no more than one second.                            

(define (foosteps x)
  (if (zero? x) 3
      (+ 1 (+ 3 2 3 (* 3 (foosteps (sub1 x))))))
  )

; (b) [5 marks] Complete the function (foofoo x) below so that (foofoo x) computes the same                            
; result as (foo x), for any non-negative integer x.  The running time to evaluate                            
; (foofoo 10000) should be no more than 1 second.                            

(define (foofoo-helper foofoo-result)
  (+ (sqrt foofoo-result) foofoo-result (/ 1 foofoo-result)))

(define (foofoo x)
  (if (zero? x) 1
      (foofoo-helper (foofoo (sub1 x))))
  )

; (c) [5 marks] Consider the function bar below.  Prove that the number of steps required                            
; to evaluate (bar x) is strictly less than the number of steps required to                            
; evaluate (foo x), for any positive integer x.                            

(define (bar x)
  (if (< x 2) 1
      (+ (sqrt (bar (sub1 x)))(bar (sub1(sub1 x))) (/ 1 (bar(sub1 x))))))

(define q1c-proof "
   For a given x > 0, (bar x) will reach its base case x < 2 in x - 1 recursive (bar (sub1 x)) calls. This applies to both the first and the third recursive call in (bar x).
   For the same x, (foo x) will reach its base case x = 0 in x recursive (foo (sub1 x)) calls. This applies to both the first and the third recursive call in (foo x).

   x - 1 < x and therefore (foo x) will have more recursive calls than (bar x), ignoring the second recursive call in each function for now.

   For a given x > 0, (bar x) will reach its base case x < 2 in (quotient x 2) recursive (bar (sub1 (sub1 x))) calls. This applies to the second recursive call in (bar x).
   For the same x, (foo x) will still reach its base case x = 0 in x recursive (foo (sub1 x)) calls. This applies to both the first and the third recursive call in (foo x).

   (quotient x 2) < x and therefore (foo x) will have more recursive calls than (bar x) for the second recursive call.

   => All recursive calls in a given instance of (bar x) will themselves require recursive depth than all recursive calls in a given instance of (foo x).
   
   In each recursive call, (bar x) and (foo x) perform the exact same functions on the recursive results as each other, meaning they require the same number of steps in each instance.
   However, the number of instance calls in (bar x) is always less than in (foo x) for positive integer x, which proves that the number of steps required to evaluate (bar x) is strictly less than the number of steps required to evaluate (foo x).

   QED (end of proof)

   ")

; (d) [5 marks] Complete the function (barbar x) below.  (barbar x) should compute the same result                            
; as (bar x) for any non-negative integer x.  The running time to evaluate (barbar 10000)                            
; should be less than 1 second.

(define (barbar-helper barbar-result)
  (+ (sqrt barbar-result) (- barbar-result 1) (/ 1 barbar-result)))

(define (barbar x)
  (if (< x 5) (bar 4)
      (barbar-helper (barbar (sub1 x))))
  )                

; Question 2 [2 parts X 5 marks = 10 marks]                            

; Consider a binary search tree constructed using bnode as defined                            
; below. The fields left and right are the subtrees, key is a real number                            
; representing an element in the bst, and height is the height of the tree                            
; represnted by the bnode.                            

(define-struct bnode (left key height right))

; (a) [5 marks] Complete the functions (binsert e t) that inserts an element e                            
; into t, and (bheight t) that computes the height of t.  bheight must not be                            
; recursive and must not use a recursive helper function.

(define (node-maker l r parent-key)
  (cond
    [(and (empty? l) (empty? r)) (make-bnode empty parent-key 1 empty)]
    [(empty? l) (make-bnode l parent-key (add1 (bnode-height r)) r)]
    [(or (empty? r) (> (bnode-height l) (bnode-height r))) (make-bnode l parent-key (add1 (bnode-height l)) r)]
    [true (make-bnode l parent-key (add1 (bnode-height r)) r)]))

(define (binsert e t)
  (cond
    [(empty? t) (make-bnode empty e 1 empty)]
    [(< e (bnode-key t)) (node-maker (binsert e (bnode-left t)) (bnode-right t) (bnode-key t))]
    [true (node-maker (bnode-left t) (binsert e (bnode-right t)) (bnode-key t))]
  ))

(define (bheight t)
  (bnode-height t)
  )

; For example, given the definition                            
;  (define q (binsert 20 (binsert 30 (binsert 40 (binsert 25 empty)))))                            
; the value of q should be                            
;  (make-bnode (make-bnode '() 20 1 '()) 25 3 (make-bnode (make-bnode '() 30 1 '()) 40 2 '()))                            

; (b) [5 marks] Complete the function (bprune t) below.  (bprune t) must remove                            
; the node from t that is farthest from the root, where t is a binary search                            
; tree, as defined above. If many nodes are farthest from the root, bprune should                            
; remove the one with the maximum key value.  The number of recursive applications                            
; of bprune or any helper function should not exceed the height of t.  Your solution                             
; may assume correct ; implementations of binsert and bheight from part (a) above.                              
; Your solution may also use any helper functions you may have defined for part (a).                            

(define (bprune t)
  (cond
    [(and (empty? (bnode-left t)) (empty? (bnode-right t))) empty]
    [(empty? (bnode-left t)) (node-maker empty (bprune (bnode-right t)) (bnode-key t))]
    [(empty? (bnode-right t)) (node-maker (bprune (bnode-left t)) empty (bnode-key t))]
    [(>= (bnode-height (bnode-right t)) (bnode-height (bnode-left t))) (node-maker (bnode-left t) (bprune (bnode-right t)) (bnode-key t))]
    [true (node-maker (bprune (bnode-left t)) (bnode-right t) (bnode-key t))])
  )

; For example, the value of                            
;   (bprune q)                            
; should be                            
;   (make-bnode (make-bnode '() 20 1 '()) 25 2 (make-bnode '() 40 1 '()))                            

;  === END OF EXAMINATION ===                            


