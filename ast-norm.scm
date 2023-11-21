(define (make-ast-norm-context)
    (struct 'file "unknown.jl"
            'line 0))

(define (normalise-ast ast)
    (assert (= (cadr ast) 'toplevel)
            "only shalt thou call `normalise-ast` on top level ASTs")
    (map-filter-to-vec (lambda (e) (imp-normalise-ast (make-ast-norm-context) e))
                       (lambda (r) (not (null? r)))
                       (cddr ast)))

(define (imp-normalise-ast ctx ast)
    (if (= (car ast) 'linenum)
        (begin (define file (cadr ast))
               (define line (cddr ast))
               (set-field! ctx 'file file)
               (set-field! ctx 'line line)
               null)
        (begin (define result (imp-normalise-ast-concrete ctx ast))
               (set-field! result 'file (get-field ctx 'file))
               (set-field! result 'line (get-field ctx 'line))
               result)))

(define (imp-normalise-ast-concrete ctx ast)
    (assert (= (car ast) 'expr)
            "elements other than line numbers should be always expressions")
    (define k (cadr ast))
    (define body (cddr ast))
    (cond [(= k 'function) (imp-normalise-function ctx body)]
          [(= k 'struct) (imp-normalise-struct ctx body)]
          [(= k 'abstract) (imp-normalise-abstract-type ctx body)]
          [(= k 'call) (imp-normalise-call ctx body)]
          [otherwise (error "unknown discriminant: " k)]))
