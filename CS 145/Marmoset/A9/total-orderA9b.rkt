#lang scheme

;; Total Order ADT used by Ordered Set ADT

;; Must provide:
;;   a membership predicate
;;   a total order
;;   min and max functions with identities
;;   user-defined associative operator and identity
;;
;;   any other operations required by the user
;;       e.g. to-hide and to-unhide

(provide to? to< to<= to> to> to>= to= to!= to-min to-min-ident 
         to-max to-max-ident to-op to-op-ident to-hide to-unhide)

;; For this example, we use a number hidden in a struct

   (define-struct to-rep (number count))
   (define (to-unhide x) (list (to-rep-number x) (to-rep-count x)))
   (define (to-hide x) (make-to-rep (car x) (cadr x)))

;; membership predicate

   (define (to? x) (and (to-rep? x) (number? (to-rep-number x)) (number? (to-rep-count x))))

;; defining relation must be total, reflexive, transitive
   (define (to<= a b)
     (or (< (to-rep-number a) (to-rep-number b)) (and (= (to-rep-number a) (to-rep-number b)) (<= (to-rep-count a) (to-rep-count b)))))

;; derived relations
   (define (to> a b) (not (to<= a b)))
   (define (to= a b) (and (to<= a b) (to<= b a)))
   (define (to>= a b) (to<= b a))
   (define (to< a b) (to> b a))
   (define (to!= a b) (not (to= a b)))

;; min/max functions and identities
   
   (define (to-min a b) (if (to< a b) a b))
   (define to-min-ident (make-to-rep +inf.0 +inf.0))

   (define (to-max a b) (if (to< a b) b a))
   (define to-max-ident (make-to-rep -inf.0 -inf.0))

;; user-defined associative operator and identity

;; for this example we just add the secret numbers

   (define (to-op a b) (to-hide (list (+ (to-rep-number a) (to-rep-number b)) 0)))
   (define to-op-ident (to-hide (list 0 0)))