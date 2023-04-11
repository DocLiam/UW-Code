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
    [else #f]))

(define MAX-DEPTH 1)

(define STD-SPACE 50)

(define LABEL-COUNT 0)

(define skip-instr #f)

(define current-fn "")

(define arg-names-table (make-hash))

(define fun-var-names-table (make-hash))

(define must-return #f)

(define check-arg-count #t)

(define (compile-statement s-exp offset)
  (define prev-max-depth MAX-DEPTH)
  (if (> (+ offset 1) MAX-DEPTH) (set! MAX-DEPTH (+ offset 1)) void)
  (match s-exp
    [`(seq) empty]
    [`(and) empty]
    [`(or) empty]
    [`(skip) empty]
    [`(return ,aexp) (begin (set! must-return #f)
                            (append (if (list? aexp) (compile-statement aexp offset) empty)
                             (list (list 'move (string->symbol (string-append "_RETURN_VALUE_" current-fn)) (if (list? aexp) (list offset 'PtoSP) (compile-statement aexp 0))))))]
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
     (if (= (length stmt) 1) (set! must-return #t) void)
     (define SKIP-LABEL (string->symbol (string-append "LABEL" (number->string LABEL-COUNT))))
     (if skip-instr (set! LABEL-COUNT (+ LABEL-COUNT 1)) void)
     (append (if skip-instr (list (list 'jump SKIP-LABEL)) empty) (compile-statement (first stmt) offset) (if skip-instr (begin (set! skip-instr #f) (list (list 'label SKIP-LABEL))) (begin (if (equal? '(skip) (first stmt)) (set! skip-instr #t) void) empty)) (compile-statement (cons 'seq (rest stmt)) offset))]
    [`(,op ,aexp ...)
     (if (op-match op)
         (append (if (list? (first aexp)) (compile-statement (first aexp) offset) empty) (if (list? (second aexp)) (compile-statement (second aexp) (+ offset 1)) empty)
                 (list (list (op-match op) (list offset 'PtoSP)
                             (if (list? (first aexp)) (list offset 'PtoSP) (compile-statement (first aexp) 0))
                             (if (list? (second aexp)) (list (+ offset 1) 'PtoSP) (compile-statement (second aexp) 0)))))
         (if (empty? aexp) empty
             (begin
               (if check-arg-count
                   (begin (set! check-arg-count #f) (if (not (= (length aexp) (vector-length (hash-ref arg-names-table (symbol->string op))))) (error "arguments") void))
                   void)
               (append (begin (set! check-arg-count #t) (if (list? (first aexp)) (compile-statement (first aexp) offset) empty)) (begin (set! check-arg-count #f) empty)
                     (list (list 'move (string->symbol (string-append "_TEMP_" (symbol->string op))) (if (list? (first aexp)) (list offset 'PtoSP) (compile-statement (first aexp) 0))))
                     (list (list 'add (string->symbol (string-append "_DEPTH_" (symbol->string op))) (string->symbol (string-append "_DEPTH_" (symbol->string op))) 1))
                     (list (list 'move
                                 (list (string->symbol (string-append "_ARG_" (symbol->string op) (symbol->string (vector-ref (hash-ref arg-names-table (symbol->string op)) (- (vector-length (hash-ref arg-names-table (symbol->string op))) (length aexp)))))) (string->symbol (string-append "_DEPTH_" (symbol->string op))))
                                 (string->symbol (string-append "_TEMP_" (symbol->string op)))))
                     (list (list 'sub (string->symbol (string-append "_DEPTH_" (symbol->string op))) (string->symbol (string-append "_DEPTH_" (symbol->string op))) 1))
                     (compile-statement (cons op (rest aexp)) offset)
                     (if (= (length aexp) (vector-length (hash-ref arg-names-table (symbol->string op))))
                         (begin (set! check-arg-count #t)
                           (append
                          (list (list 'add (string->symbol (string-append "_DEPTH_" (symbol->string op))) (string->symbol (string-append "_DEPTH_" (symbol->string op))) 1))
                          (list (list 'add 'PtoSP 'PtoSP 1))
                          (list (list 'jsr (list (string->symbol (string-append "_RETURN_ADDR_" (symbol->string op))) (string->symbol (string-append "_DEPTH_" (symbol->string op)))) (string->symbol (string-append "START_LABEL_" (symbol->string op)))))
                          (list (list 'sub (string->symbol (string-append "_DEPTH_" (symbol->string op))) (string->symbol (string-append "_DEPTH_" (symbol->string op))) 1))
                          (list (list 'sub 'PtoSP 'PtoSP 1))
                          (list (list 'move (list offset 'PtoSP) (string->symbol (string-append "_RETURN_VALUE_" (symbol->string op)))))))
                         empty)))))]
    [`,x (begin (set! MAX-DEPTH prev-max-depth)
                (if (symbol? x)
                    (if (or (equal? x 'true) (equal? x 'false)) (equal? x 'true) (list (string->symbol (string-append "_ARG_" current-fn (symbol->string x))) (string->symbol (string-append "_DEPTH_" current-fn))))
                    x))]))

(define (first-pass fn-defs arg-index fn-name)
  (match fn-defs
    [`() empty]
    [`((fun (,fn ,id ...) ,body) ,rest ...) (begin (if (hash-has-key? arg-names-table (symbol->string fn)) (error "duplicate") void)
                                                   (hash-set! arg-names-table (symbol->string fn) (make-vector (length id) 0))
                                                   (hash-set! fun-var-names-table (symbol->string fn) (make-hash))
                                                   (first-pass id 0 (symbol->string fn))
                                                   (first-pass rest 0 ""))]
    [`(,id ...) (begin
                  (if (hash-has-key? (hash-ref fun-var-names-table fn-name) (first id)) (error "duplicate") void)
                  (hash-set! (hash-ref fun-var-names-table fn-name) (first id) #t)
                  (vector-set! (hash-ref arg-names-table fn-name) arg-index (first id))
                  (first-pass (rest id) (+ arg-index 1) fn-name))]))

(define start-flag #t)

(define (compile-simpl fn-defs)
  (if start-flag (begin (first-pass fn-defs 0 "") (set! start-flag #f)) void)
  (match fn-defs
    [`() empty]
    [`(vars [,defs ...] (seq ,stmt ...)) (append (compile-statement (cons 'seq stmt) 0) (compile-simpl defs))]
    [`(vars [,defs ...] ,stmt ...) (append (compile-statement (cons 'seq stmt) 0) (compile-simpl defs))]
    [`((,id ,number) ,rest ...) (begin
                                  (if (hash-has-key? (hash-ref fun-var-names-table current-fn) id) (error "duplicate") void)
                                  (append (list (list 'data (string->symbol (string-append "_ARG_" current-fn (symbol->string id))) (list STD-SPACE number))) (compile-simpl rest)))]
    [`((fun (,fn ,id ...) (vars [,defs ...] ,body ...)) ,rest ...) (begin (set! current-fn (symbol->string fn))
                                                                          (define first-body (compile-statement (cons 'seq body) 0))
                                                   (define first-fn (append (list (list 'label (string->symbol (string-append "START_LABEL_" current-fn))))
                                                                            (if (and (symbol=? 'move (first (last first-body))) (symbol=? (string->symbol (string-append "_RETURN_VALUE_" current-fn)) (second (last first-body)))) first-body (error "must return"))
                                                                            (if (symbol=? fn 'main) (list (list 'halt)) (list (list 'jump (list (string->symbol (string-append "_RETURN_ADDR_" current-fn)) (string->symbol (string-append "_DEPTH_" current-fn))))))
                                                                            (list (list 'data (string->symbol (string-append "_DEPTH_" current-fn)) 0))
                                                                            (list (list 'data (string->symbol (string-append "_RETURN_ADDR_" current-fn)) (list STD-SPACE 0)))
                                                                            (list (list 'data (string->symbol (string-append "_RETURN_VALUE_" current-fn)) 0))
                                                                            (list (list 'data (string->symbol (string-append "_TEMP_" current-fn)) 0))
                                                                            (compile-simpl defs)
                                                                            (compile-simpl id)))
                                                   (define rest-fn (compile-simpl rest))
                                                   (if (symbol=? fn 'main) (append first-fn (list (list 'data 'PtoSP 'SP)) (list (list 'data 'SP (list (* STD-SPACE 4) 0))) rest-fn) (append rest-fn first-fn)))]
    [`(,id ...) (append (list (list 'data (string->symbol (string-append "_ARG_" current-fn (symbol->string (first id)))) (list STD-SPACE 0))) (compile-simpl (rest id)))]
    [else
     (compile-statement fn-defs 0)]))