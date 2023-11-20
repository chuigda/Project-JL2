(define (make-astconv-ctx)
    (struct 'file "unknown"
            'line 1))

(define (astconv ast)
    (imp-astconv (make-astconv-ctx) ast))

(define (imp-astconv ctx ast)
    (if (pair? ast)
        (begin
            (define kind (car ast))
            (cond [(= kind 'expr)
                   (begin (define converted (imp-astconv-expr ctx ast))
                          (set-field! converted 'line
                                      (get-field ctx 'line))
                          (set-field! converted 'file
                                      (get-field ctx 'file))
                          converted)]
                  [(= kind 'linenum)
                   (begin (set-field! ctx 'file (car ast))
                          (set-field! ctx 'line (cdr ast))
                          '())]
                  [otherwise (error "astconv: unknown kind: " kind)]))
        ast))

(define (imp-astconv-expr ctx expr)
    (define head (cadr expr))
    (define args (map-filter-to-vec (lambda (e) (imp-astconv ctx e))
                                    (lambda (e) (not (null? e)))
                                    (cddr expr)))
    (cond [(= head 'toplevel) (make-top-level args)]
          [(= head 'block) (make-block args)]
          [(= head 'tuple) (make-tuple args)]
          [(= head 'function) (imp-astconv-func args)]
          [(= head 'call) (make-call (vector-ref args 1) args)]
          [(= head '::)
           (begin (assert (= (vector-length args) 2)
                          "type annotation node should have 2 parts")
                  (define item (vector-ref args 0))
                  (define type (vector-ref args 1))
                  (make-typed-item item type))]
          [otherwise (error "astconv: unknown expr head: " head)]))

(define (imp-astconv-func args)
    (assert (= (vector-length args) 2)
            "function definition should have got 2 parts: signature and body")
    (define sig (vector-ref args 0))
    (define body (vector-ref args 1))
    (define sig-k (get-field sig 'k))

    (cond [(= sig-k 'call)
           (begin (define ret-type '())
                  (define func-name (get-field sig 'f))
                  (define param-list (get-field sig 'args)))]
          [(= sig-k 'typed)
           (begin (define ret-type (get-field sig 'type))
                  (define sig-no-ret (get-field sig 'item))
                  (define func-name (get-field sig-no-ret 'f))
                  (define param-list (get-field sig-no-ret 'args)))]
          [otherwise (error "function signature should be either a call node"
                            " or a typed-item node")])
    (make-function func-name param-list ret-type))
