;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname A6f) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(require "avl-cs145.rkt")

;; An instance of the type 'set' is represented using an AVL tree and where each set member is represented in the AVL tree in ascending order of the member's value



;; We define the variable 'emptyset' as the built-in 'empty' identifier, so that we can abstract the concept of an empty set for our type 'set'
(define emptyset empty)



;; We define the function '(emptyset? s)' as a reused/copied version of the built-in '(empty? s)' function, again to conceptually differentiate it from other types that may be empty (think BSTs, lists, AVLs etc.)
;; The efficiency is defined by O(1), since it *always* takes just a single step to check if the value 's' given is 'empty'. In other words, the efficiency of the function '(empty? n)' used is O(1), therefore the efficiency of '(emptyset? s)' is O(1) too
(define (emptyset? s)
  (empty? s))



;; We define the function '(singleton n)' as taking 'n' and inserting it into the 'emptyset' using the function '(insertavl t n)', and so the returned value is a set with a single member 'n'
;; The efficiency is defined by O(1), since it only uses one other function '(insertavl t n)', which has efficiency O(N) where N is the size of 't', but since it is always the empty set, this means efficiency is defined by O(1)
(define (singleton n)
  (insertavl emptyset n))



;; We define the function '(union s1 s2)' as returning the set containing all members contained in 's1' *or* 's2'
;; First we check which of 's1' and 's2' has less members, and then pass these sets to '(union-helper s1 s2)' with 's1' being the smaller of the two sets, and 's2' being the larger set
;; Within '(union-helper s1 s2)', we first check if the set 's1' is empty, in which case we have reached a leaf of the AVL representing the original 's1', and thus we return 's2'
;; If 's1' is not empty, we recursively call '(union-helper s1 s2)' with the new 's1' being the left sub-tree of the current 's1', and the new 's2' being the current 's2' with the current member of 's1' added using '(insertavl t n)'
;; We then recursively call '(union-helper s1 s2)' again, with the new 's1' being the right sub-tree of the current 's1', and the new 's2' being the result returned from the preceding recursive call
;; This works because we know that '(insertavl t n)' can handle if 'n' already exists in 't', so there will be no repeats. This means that the final 's2' returned will contain all members of the original 's2', and all members of 's1', as needed
;; The efficiency is defined by O(N*logM), since we know that traversing 's1' in '(union-helper s1 s2)' is O(N) where N is the size of 's1' (smallest set), and for every member visited, the efficiency of '(insertavl t n)' is O(logM) where M is the size of 's2'. Therefore the total efficiency is O(N)*O(logM)=O(N*logM)
(define (union s1 s2)
  (if (= (size s1) (min (size s1) (size s2)))
      (union-helper s1 s2)
      (union-helper s2 s1)))

(define (union-helper s1 s2)
  (cond
    [(emptyset? s1) s2]
    [true (union-helper (node-right s1) (union-helper (node-left s1) (insertavl s2 (node-key s1))))]))



;; We define the function '(intersection s1 s2)' as returning the set containing all members contained in 's1' *and* 's2'
;; First we check which of 's1' and 's2' has less members, and then pass these sets to '(intersection-helper s1 s2 s3)' with 's1' being the smaller of the two sets, 's2' being the larger set, and 's3' being the same as 's1' since we will progressively remove members to get the intersection of 's1' and 's2'
;; Within '(intersection-helper s1 s2)', we first check if the set 's1' is empty, in which case we have reached a leaf of the AVL representing the original 's1', and thus we return 's3', which is the set we are adapting to be '(intersection s1 s2)'
;; If 's1' is not empty, we recursively call '(intersection-helper s1 s2 s3)' with the new 's1' being the left sub-tree of the current 's1', the new 's2' being the current 's2', and the new 's3' being the current 's3' *if* the current member of 's1' already exists in 's2' using '(insertavl t n)', *else* the new 's3' becomes the current 's3' with the current member of 's1' removed using '(deleteavl t n)' [this ensures that if a member of 's1' does not exist in 's2', we delete that from the final intersection set, since we want those which *are* contained in both sets] 
;; We then recursively call '(intersection-helper s1 s2)' again, with the new 's1' being the right sub-tree of the current 's1', the new 's2' being the current 's2', and the new 's3' being the result returned from the preceding recursive call
;; This works because we know that '(insertavl t n)' can handle if 'n' already exists in 't', in which case the size will be equal to what it was before (implies it exists in both sets). Subsequently, we know that if the current member of 's1' does not exist in 's2', we need to remove it from 's3', since it is not in the intersection. This means that the final 's3' returned will contain all members that are contained in 's1' *and* 's2'
;; The efficiency is defined by O(N*logM), since we know that traversing 's1' in '(intersection-helper s1 s2)' is O(N) where N is the size of 's1' (smallest set), and for every member visited, the efficiency of '(insertavl t n)' is O(logM) and the efficiency of '(deleteavl t n)' is also O(logM) where M is the size of 's2'. Therefore the total efficiency is O(N)*2*O(logM)=O(N*logM)
(define (intersection s1 s2)
  (if (= (size s1) (min (size s1) (size s2)))
      (intersection-helper s1 s2 s1)
      (intersection-helper s2 s1 s2)))

(define (intersection-helper s1 s2 s3)
  (cond
    [(emptyset? s1) s3]
    [true (intersection-helper (node-right s1) s2 (intersection-helper (node-left s1) s2 (if (= (size (insertavl s2 (node-key s1))) (size s2)) s3 (deleteavl s3 (node-key s1)))))]))



;; We define the function '(difference s1 s2)' as returning the set containing all members contained in 's1' but *not* in 's2'
;; First we check if the set 's2' is empty, in which case we have reached a leaf of the AVL representing the original 's2', and thus we return 's1'
;; If 's2' is not empty, we recursively call '(difference s1 s2)' with the new 's1' being the current 's1' with the current member of 's2' deleted using '(deleteavl t n)', and the new 's2' being the left sub-tree of the current 's2'
;; We then recursively call '(difference s1 s2)' again, with the new 's1' being the result of the preceding recursive call, and the new 's2' being the right sub-tree of the current 's2'
;; This works because we know that '(deleteavl t n)' can handle if 'n' does not exist in 't', and if it does exist in 't' then the set will be reduced so that no members remaining are *also* in 'the original 's2'
;; The efficiency is defined by O(N*logM), since we know that traversing 's2' in '(difference s1 s2)' is O(N) where N is the size of 's2', and for every member visited, the efficiency of '(deleteavl t n)' is O(logM) where M is the size of 's1'. Therefore the total efficiency is O(N)*O(logM)=O(N*logM)
(define (difference s1 s2)
  (cond
    [(emptyset? s2) s1]
    [true (difference (difference (deleteavl s1 (node-key s2)) (node-left s2)) (node-right s2))]))



;; We define the function '(size s)' as a reused version of the provided function '(sizeavl t)' function, again to conceptually differentiate it from other types that may be empty (think BSTs, lists, AVLs etc.)
;; It simply returns the number of members (size) in 's'
;; The efficiency is defined by O(1), since it only uses one other function '(sizeavl t)', which has efficiency O(1)
(define (size s)
  (sizeavl s))



;; We define the function '(nth s i)' as returning the 'i'th index member value if the set 's' was sorted ascendingly
;; First, we pass 's', '0' and 'i' into the function '(nth-helper s preceding-size i)' where 'preceding-size' tracks how many "lesser than" elements we have already ruled out
;; Then within '(nth-helper s preceding-size i)', we check whether the size of the left sub-tree plus preceding-size is equal to i, in which case the current member of 's' is the one we are looking for, and we return it
;; If instead, the sum is less than i, this means the result will be in the current right sub-tree, so we recursively call '(nth-helper s preceding-size i)' again with the new 's' being the right sub-tree of the current 's', the new 'preceding-size' being the size of the left sub-tree plus the current 'preceding-size' plus '1' (because the left sub-tree is now ruled out), and the new 'i' being the current 'i'
;; If neither is true, the result will be in the current left sub-tree, so we recursively call '(nth-helper s preceding-size i)' with the new 's' being the left sub-tree of the current 's', the new 'preceding-size' being the current 'preceding-size', and the new 'i' being the current 'i'
;; This works because '(size s)' can handle if 's' is empty (so the 'i'th member is a leaf), and we know that the sub-tree we pick will always have the 'i'th member, assuming 0=<i<size of s
;; The efficiency is defined by O(logN), where N is the size of 's', since we know that each recursive call will choose either the left or right sub-tree, until the answer is found. This means O(H) where H is the height of the AVL tree representing 's', which is also written as O(logN)
(define (nth s i)
  (nth-helper s 0 i))

(define (nth-helper s preceding-size i)
  (cond
    [(= (+ (size (node-left s)) preceding-size) i) (node-key s)]
    [(< (+ (size (node-left s)) preceding-size) i) (nth-helper (node-right s) (+ (size (node-left s)) preceding-size 1) i)]
    [true (nth-helper (node-left s) preceding-size i)]))