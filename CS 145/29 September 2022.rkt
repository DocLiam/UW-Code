;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-abbr-reader.ss" "lang")((modname |29 September 2022|) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(define x (cons 1 (cons 2 (cons 'fred empty))))

(car x)

(cdr x)

(first x) ; alias for car

(rest x) ; alias for cdr

(list 1 2 'fred)

(list) ; empty

(define y (list 1 2 3 4 5 true))

(define z (list x empty y))

(list-ref x 0)

(list-ref x 2)

(define (mylist-ref lst n)
  (if (zero? n) (car lst) (mylist-ref (cdr lst) (sub1 n))))

(cadr y) ; car of cdr

(caddr y) ; car of cdr of cdr

(cadddr y) ; car of cdr of cdr of cdr

(caar z) ; car of car

(first (first z))

(member empty z) ; is element in list

(define (mymember e lst)
  (cond
    [(empty? lst) false]
    [(equal? e (car lst)) true]
    [true (mymember e (cdr lst))]))

(define (mylength lst)
  (if (empty? lst) 0 (add1 (mylength (cdr lst)))))

(define (listadd e lst)
  (cons e lst))

(define (delfirst lst)
  (cdr  lst))

(define (dellast lst)
  (cond
    [(empty? lst) lst]
    [(empty? (cdr lst)) empty]
    [true (cons (car lst) (dellast (cdr lst)))]))

(define (addlast lst e)
  (cond
    [(empty? lst) (cons e empty)]
    [true (cons (car lst) (addlast (cdr lst) e))]))

(define (myappend a b)
  (cond
    [(empty? a) b]
    [true (cons (car a) (myappend (cdr a) a))]))

(define (mybadrev lst)
  (cond
    [(empty? lst) empty]
    [ true (addlast (mybadrev (cdr lst)) (car lst))]))

(define (bild n)
  (if (zero? n) (cons n empty) (cons n (bild (sub1 n)))))

(define (revhelp lst acc) ;reverses list, appends reversed list, acc
  (cond
    [(empty? lst) acc]
    [true (revhelp (cdr lst) (cons (car lst) acc))]))

(define (myrev lst) (revhelp lst empty))