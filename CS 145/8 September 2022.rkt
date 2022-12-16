;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname |8 September 2022|) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
42

(+ 42 21)

(+ (+ 1 2) (+ 1 3))

(define (dubble x) (+ x x)) ; functional abstraction (function definition)

(dubble 1) ; function application (apply dubble to argument 1)
(dubble 20) ; apply dubble to argument 20

(dubble (dubble 1)) ; apply dubble twice

(define (my-function a) (* a a))

(my-function 100)