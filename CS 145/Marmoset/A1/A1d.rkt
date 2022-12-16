;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-reader.ss" "lang")((modname A1d) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;Part f

(if (< (remainder 7861248612348 1024) 512) (+ 1 2) (+ (+ 1 2) 3))

(define step-count-f 5)

;Part g

(define (g x) (if (< (remainder x 1024) 512) (+ 1 2) (+ (+ 1 2) 3)))

(g 91236871364879817234173413789478912347891278934)

(define step-count-g 5)

;Part h

(define (sum x)
  (if (= x 0) 0 (+ (sum (- x 1)) (if (< (remainder x 1024) 512) 5 6))))

(define (mean x) (/ (sum x) x))

(define step-count-h (mean 1000000))

;Part i

(define step-count-i 5.5)

;Part j

(define step-count-j 5.25)