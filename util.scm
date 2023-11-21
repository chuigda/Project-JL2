(define (cadr x) (car (cdr x)))
(define (cddr x) (cdr (cdr x)))
(define (caddr x) (car (cdr (cdr x))))
(define (cdddr x) (cdr (cdr (cdr x))))
(define (cadddr x) (car (cdr (cdr (cdr x)))))
(define (cddddr x) (cdr (cdr (cdr (cdr x)))))

(define list-fst car)
(define list-snd cadr)
(define list-3rd caddr)
(define list-4th cadddr)

(define (map-filter-to-vec mapper filter xs)
    (define ret (vector))
    (define value '())
    (loop
        (if (null? xs) (break ret))
        (set! 'value (mapper (car xs)))
        (if (filter value)
            (vector-push! ret value))
        (set! 'xs (cdr xs))))

(define (repeat-call f n)
    (loop
        (if (= n 0) (break))
        (f)
        (set! 'n (- n 1))))

(define null '())