(define (pretty-print s-expr)
    (imp-pretty-print 0 s-expr))

(define (imp-pretty-print indent s-expr)
    (repeat-call (lambda () (print "  ")) indent)
    (cond [(not (pair? s-expr)) (println s-expr)]
          [(= 'linenum (car s-expr))
           (println "#line " (cadr s-expr) ":"(cddr s-expr))]
          [(= 'expr (car s-expr))
           (begin (println (cadr s-expr))
                  (foreach (lambda (e) (imp-pretty-print (+ indent 1) e))
                           (cddr s-expr)))]))
