;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname A4c) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(define (factorial n)
  (if (< n 1) 1 (* (factorial (- n 1)) n)))

(define (tree-count n)
  (/ (factorial (* n 2)) (* (factorial (+ n 1)) (factorial n))))