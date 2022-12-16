;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-abbr-reader.ss" "lang")((modname A5b) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(define-struct node (left right key))

(define-struct new-node (left right height sz))

(define (special-make-node decorated-left decorated-right)
  (make-new-node decorated-left decorated-right (+ 1 (max (new-node-height decorated-left) (new-node-height decorated-right))) (+ 1 (new-node-sz decorated-left) (new-node-sz decorated-right))))

(define (decorate t)
  (cond
    [(empty? t) (make-new-node empty empty 0 0)]
    [true (special-make-node (decorate (node-left t)) (decorate (node-right t)))]))

(define (check-full decorated)
  (= (sub1 (expt 2 (new-node-height decorated))) (new-node-sz decorated)))

(define (full? t)
  (cond
    [(empty? t) #true]
    [true (check-full (decorate t))]))

(define (check-balance decorated)
  (>= 1 (abs (- (new-node-sz (new-node-left decorated)) (new-node-sz (new-node-right decorated))))))

(define (balanced? t)
  (cond
    [(empty? t) #true]
    [true (check-balance (decorate t))]))