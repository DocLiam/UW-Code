;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname |20 September 2022|) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;; bunch2: A bunch2 is a posn where the x and y fields each contain an element (which is not a posn) or a bunch

;; bunch1: A bunch1 is either a single element (not a posn) or a posn where the x and y fields are both bunch1s

(define f (make-posn 'fred (make-posn 'wilma (make-posn 'barney 'betty))))

(define (bunch2? b) ; is b a bunch2?
  (and (posn? b) (and (or (bunch2? (posn-x b)) (not (posn? (posn-x b))))
                      (or (bunch2? (posn-y b)) (not (posn? (posn-y b)))))))

(define (bunch1? b) ; is b a bunch1?
  (or (not (posn? b)) (and (bunch1? (posn-x b)) (bunch1? (posn-y b)))))

(define (count b) ; number of elements is a bunch1
  (if (posn? b) (+ (count (posn-x b)) (count (posn-y b)))
      1))

(define (countelem e b) ; how many times does element e occur in b?
  (cond
    [(posn? b) (+ (countelem (posn-x e b)) (countelem (posn-y b)))]
    [(equal? e b) 1]
    [true 0]))

(define f2 (make-posn f f))
(define f4 (make-posn f2 f2))
(define f8 (make-posn f4 f4))

(define (remelem e b) ; remove all instances of element e from b
  ; example: (remelem 'fred (make-posn 'fred 'wilma)) is 'wilma
  ;          (remelem 'fred (make-posn 'fred 'fred)) is ???? not a bunch1
  ;   define bunch0: empty or element (not posn or empty) or bunch1
  (cond
   [(equal? e b) empty]
   [(posn? b)
       (make-posn (remelem e (posn-x b)) (remelem e (posn-y b)))] ; wrong
   [true b]))

(define (my-make-posn a b)
  (cond
    [(empty? a) b]
    [(empty? b) a]
    [true (make-posn a b)]))