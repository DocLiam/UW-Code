#lang racket

; Written by myself (other potential collaborators already had partners)

(define (op-match op)
  (match op
    [`+ 'add]
    [`* 'mul]
    [`- 'sub]
    [`div 'div]
    [`mod 'mod]
    [`= 'equal]
    [`> 'gt]
    [`< 'lt]
    [`>= 'ge]
    [`<= 'le]
    [`not 'lnot]
    [`and 'land]
    [`or 'lor]))

(define MAX-DEPTH 1)

(define LABEL-COUNT 0)

(define skip-instr #f)

(define (compile-statement s-exp offset)
  (define prev-max-depth MAX-DEPTH)
  (if (> (+ offset 1) MAX-DEPTH) (set! MAX-DEPTH (+ offset 1)) void)
  (match s-exp
    [`(seq) empty]
    [`(and) empty]
    [`(or) empty]
    [`(skip) empty]
    [`(print ,aexp-or-string) (if (string? aexp-or-string) (list (list 'print-string aexp-or-string)) (if (list? aexp-or-string) (append (compile-statement aexp-or-string offset) (list (list 'print-val (list offset 'PtoSP)))) (list (list 'print-val (compile-statement aexp-or-string offset)))))]
    [`(set ,id ,aexp) (append (if (list? aexp) (compile-statement aexp offset) empty) (list (list 'move (compile-statement id 0) (if (list? aexp) (list offset 'PtoSP) (compile-statement aexp 0)))))]
    [`(not ,bexp) (append (if (or (equal? bexp 'true) (equal? bexp 'false)) empty (compile-statement bexp offset)) (list (list 'lnot (list offset 'PtoSP) (if (list? bexp) (list offset 'PtoSP) (compile-statement bexp 0)))))]
    [`(and ,bexp ...) (append (if (or (equal? (first bexp) 'true) (equal? (first bexp) 'false)) empty (compile-statement (first bexp) offset))
                              (compile-statement (cons 'and (rest bexp)) (+ offset 1))
                              (list (list 'land (list offset 'PtoSP)
                                          (if (list? (first bexp)) (list offset 'PtoSP) (compile-statement (first bexp) 0))
                                          (if (empty? (rest bexp)) '#t (list (+ offset 1) 'PtoSP)))))]
    [`(or ,bexp ...) (append (if (or (equal? (first bexp) 'true) (equal? (first bexp) 'false)) empty (compile-statement (first bexp) offset))
                              (compile-statement (cons 'or (rest bexp)) (+ offset 1))
                              (list (list 'lor (list offset 'PtoSP)
                                          (if (list? (first bexp)) (list offset 'PtoSP) (compile-statement (first bexp) 0))
                                          (if (empty? (rest bexp)) '#f (list (+ offset 1) 'PtoSP)))))]
    [`(iif ,bexp ,stmt1 ,stmt2)
     (define FIRST-LABEL (string->symbol (string-append "LABEL" (number->string LABEL-COUNT))))
     (set! LABEL-COUNT (+ LABEL-COUNT 1))
     (define SECOND-LABEL (string->symbol (string-append "LABEL" (number->string LABEL-COUNT))))
     (set! LABEL-COUNT (+ LABEL-COUNT 1))
     (define THIRD-LABEL (string->symbol (string-append "LABEL" (number->string LABEL-COUNT))))
     (set! LABEL-COUNT (+ LABEL-COUNT 1))
     (append (if (list? bexp) (compile-statement bexp offset) (list (list 'move (list offset 'PtoSP) (compile-statement bexp 0))))
             (list (list 'branch (list offset 'PtoSP) FIRST-LABEL)
                   (list 'jump SECOND-LABEL)
                   (list 'label FIRST-LABEL))
             (compile-statement stmt1 offset)
             (list (list 'jump THIRD-LABEL)
                   (list 'label SECOND-LABEL))
             (compile-statement stmt2 offset)
             (list (list 'label THIRD-LABEL)))]
     [`(while ,bexp ,stmt ...)
     (define FIRST-LABEL (string->symbol (string-append "LABEL" (number->string LABEL-COUNT))))
     (set! LABEL-COUNT (+ LABEL-COUNT 1))
     (define SECOND-LABEL (string->symbol (string-append "LABEL" (number->string LABEL-COUNT))))
     (set! LABEL-COUNT (+ LABEL-COUNT 1))
     (define THIRD-LABEL (string->symbol (string-append "LABEL" (number->string LABEL-COUNT))))
     (set! LABEL-COUNT (+ LABEL-COUNT 1))
     (append (list (list 'label FIRST-LABEL))
                   (if (list? bexp) (compile-statement bexp offset) (list (list 'move (list offset 'PtoSP) (compile-statement bexp 0))))
                   (list (list 'branch (list offset 'PtoSP) SECOND-LABEL)
                         (list 'jump THIRD-LABEL)
                         (list 'label SECOND-LABEL))
                   (compile-statement (cons 'seq stmt) offset)
                   (list (list 'jump FIRST-LABEL)
                         (list 'label THIRD-LABEL)))]
    [`(seq ,stmt ...)
     (define SKIP-LABEL (string->symbol (string-append "LABEL" (number->string LABEL-COUNT))))
     (if skip-instr (set! LABEL-COUNT (+ LABEL-COUNT 1)) void)
     (append (if skip-instr (list (list 'jump SKIP-LABEL)) empty) (compile-statement (first stmt) offset) (if skip-instr (begin (set! skip-instr #f) (list (list 'label SKIP-LABEL))) (begin (if (equal? '(skip) (first stmt)) (set! skip-instr #t) void) empty)) (compile-statement (cons 'seq (rest stmt)) offset))]
    [`(,op ,aexp1 ,aexp2)
     (define do-aexp1
       (if (number? aexp1)
           aexp1
           (compile-statement aexp1 offset)))
     (define do-aexp2
       (if (number? aexp2)
           aexp2
           (compile-statement aexp2 (+ offset 1))))
     (append (if (list? aexp1) (compile-statement aexp1 offset) empty) (if (list? aexp2) (compile-statement aexp2 (+ offset 1)) empty)
             (list (list (op-match op) (list offset 'PtoSP)
                         (if (list? aexp1) (list offset 'PtoSP) (compile-statement aexp1 0))
                         (if (list? aexp2) (list (+ offset 1) 'PtoSP) (compile-statement aexp2 0)))))]
    [`,x (begin (set! MAX-DEPTH prev-max-depth) (if (symbol? x)
             (if (or (equal? x 'true) (equal? x 'false)) (equal? x 'true) (string->symbol (string-append "_" (symbol->string x))))
             x))]))

(define (compile-simpl s-exp)
  (match s-exp
    [`() empty]
    [`(vars [,defs ...] (seq ,stmt ...)) (append (compile-statement (cons 'seq stmt) 0) (list (list 'halt)) (compile-simpl defs) (list (list 'data 'PtoSP 'SP)) (list (list 'data 'SP (list (+ MAX-DEPTH 1) 0))))]
    [`(vars [,defs ...] ,stmt ...) (append (compile-statement (cons 'seq stmt) 0) (list (list 'halt)) (compile-simpl defs) (list (list 'data 'PtoSP 'SP)) (list (list 'data 'SP (list (+ MAX-DEPTH 1) 0))))]
    [`((,id ,number) ,rest ...) (append (list (list 'data (string->symbol (string-append "_" (symbol->string id))) number)) (compile-simpl rest))]
    [else
     (compile-statement s-exp 0)]))