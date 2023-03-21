#lang racket

(require test-engine/racket-tests)

(struct bin (op fst snd) #:transparent) ; op is a symbol; fst, snd are ASTs.

(struct fun (param body) #:transparent) ; param is a symbol; body is an AST.

(struct app (fn arg) #:transparent) ; fn and arg are ASTs.

(struct seq (exp1 exp2) #:transparent)

(struct newbox (exp) #:transparent)

(struct openbox (exp) #:transparent)

(struct setbox (bexp vexp) #:transparent)

(struct result (val newstore) #:transparent)

;; An AST is a (union bin fun app).

(struct sub (name val) #:transparent #:mutable)

;; A substitution is a (sub n v), where n is a symbol and v is a value.
;; An environment (env) is a list of substitutions.

(struct closure (var body envt) #:transparent)

;; A closure is a (closure v bdy env), where
;; v is a symbol, bdy is an AST, and env is a environment.
;; A value is a (union number closure).

;; parse: sexp -> AST

(define (parse sx)
  (match sx
    [`(box ,x) (newbox (parse x))]
    [`(unbox ,x) (openbox (parse x))]
    [`(setbox ,x ,y) (setbox (parse x) (parse y))]
    [`(seq ,x ,y) (seq (parse x) (parse y))]
    [`(with ((,nm ,nmd)) ,bdy) (app (fun nm (parse bdy)) (parse nmd))]
    [`(+ ,x ,y) (bin '+ (parse x) (parse y))]
    [`(* ,x ,y) (bin '* (parse x) (parse y))]
    [`(- ,x ,y) (bin '- (parse x) (parse y))]
    [`(/ ,x ,y) (bin '/ (parse x) (parse y))]
    [`(fun (,x) ,bdy) (fun x (parse bdy))]
    [`(,f ,x) (app (parse f) (parse x))]
    [x x]))

; op-trans: symbol -> (number number -> number)
; converts symbolic representation of arithmetic function to actual Racket function
(define (op-trans op)
  (match op
    ['+ +]
    ['* *]
    ['- -]
    ['/ /]))

;; lookup: symbol env -> value
;; looks up a substitution in an environment (topmost one)

(define (lookup var env)
  (cond
    [(or (empty? env) (and (symbol? var) (symbol=? 'undefined var))) 'undefined]
    [(and (symbol? var) (symbol? (sub-name (first env))) (symbol=? var (sub-name (first env)))) (sub-val (first env))]
    [(and (number? var) (number? (sub-name (first env))) (= var (sub-name (first env)))) (sub-val (first env))]
    [else (lookup var (rest env))]))

(define (lookup2 loc sto)
  (cond
    [(empty? sto) 'undefined]
    [(= loc (sub-name (first sto))) (first sto)]
    [else (lookup2 loc (rest sto))]))

(define (setup loc sto val)
  (cond
    [(empty? sto) 'undefined]
    [(= loc (sub-name (first sto))) (cons (sub (sub-name (first sto)) val) (rest sto))]
    [else (cons (first sto) (setup loc (rest sto) val))]))
  
;; interp: AST env -> value

(define (interp ast e s)
  (match ast
    [(fun p b)
     (result (closure p b e) s)]
    [(app f x)
     (match (interp f e s)
       [(result (closure fp fb fe) s1)
        (match (interp x e s1)
          [(result y s2)
           (define nl (length s2))
           (define ne (cons (sub fp nl) fe))
           (define ns (cons (sub nl y) s2))
           (interp fb ne ns)])])]
    [(bin op x y)
     (match (interp x e s)
       [(result v s1)
        (match (interp y e s1)
          [(result w s2)
           (result ((op-trans op) v w) s2)])])]
    [(seq x y)
     (match (interp x e s)
       [(result dummy s1)
        (match (interp y e s1)
          [(result v s2)
           (result v s2)])])]
    [(newbox x)
     (match (interp x e s)
       [(result nv s1)
        (define nl (length s1))
        (define ns (cons (sub nl nv) s1))
        (result nl ns)])]
    [(openbox x)
     (match (interp x e s)
       [(result lx s1)
        (result (lookup lx s1) s1)])]
    [(setbox x y)
     (match (interp x e s)
       [(result lx s1)
        (match (interp y e s1)
          [(result nv s2)
           (define ns (setup lx s2 nv))
           (result void ns)])])]
    [x
     (if (number? x)
           (result x s)
           (result (lookup (lookup x e) s) s))]))