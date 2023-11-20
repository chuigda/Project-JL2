(define (make-call f args)
    (struct 'k    'call
            'f    f
            'args args))

(define (make-top-level expr-list)
    (struct 'k         'top-level
            'expr-list expr-list))


(define (make-block expr-list)
    (struct 'k         'block
            'expr-list expr-list))

(define (make-tuple expr-list)
    (struct 'k         'tuple
            'expr-list expr-list))

(define (make-typed-item item type)
    (struct 'k    'typed
            'item item
            'type type))

(define (make-function name param-list ret-type)
    (struct 'k          'func
            'name       name
            'param-list param-list
            'ret-type   ret-type))

(define (ast-dump ast)
    (imp-ast-dump 0 ast))

(define (print-space) (print "\t"))

(define (imp-ast-dump indent ast)
    (error "not implemented"))
