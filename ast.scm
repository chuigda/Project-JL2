(define (make-type-constraint type-var constraint)
    (struct 'k          'type-constraint
            'type-var   type-var
            'constraint constraint))

(define (make-forall-type type-vars body)
    (struct 'k         'forall-type
            'type-vars type-vars
            'body      body))

(define (make-struct-type type-name mutable fields)
    (struct 'k       'struct-type
            'mutable mutable
            'fields  fields))

(define (make-abstract-type type)
    (struct 'k    'abstract-type
            'type type))

(define (make-var name type)
    (struct 'k    'var
            'name name
            'type type))

(define (make-func type-vars params ret-type body)
    (struct 'k         'func
            'type-vars type-vars
            'params    params
            'ret-type  ret-type
            'body      body))

(define (make-expr op args)
    (struct 'k    'expr
            'op   op
            'args args))
