(define e (jl-parse "sample/drill.jl"))

; (pretty-print e)

(display (vector-length (normalise-ast e)))
