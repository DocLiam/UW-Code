#lang lazy
(lambda(a) (((lambda (f) ((lambda (self) (f (self self))) (lambda (self) (f (self self)))))
            (lambda (add1)
              (lambda (num)
                (((num (lambda (yes) (lambda (no) (lambda (x) (lambda (y) y)))))
                 (lambda (selector) ((selector (lambda (x) (lambda (y) x))) num)))
                 (((num (lambda (x) (lambda (y) x))) (lambda (selector) ((selector (lambda (x) (lambda (y) y))) (add1 (num (lambda (x) (lambda (y) y)))))))
                  (lambda (selector) ((selector (lambda (x) (lambda (y) x))) (num (lambda (x) (lambda (y) y)))))))))) a))