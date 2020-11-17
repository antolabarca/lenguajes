;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;               TESTS - TAREA 2                 ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
#lang play
(require "P2.rkt")
(print-only-errors #t)

;; tests de parse
(test (parse 'True) (bool #t))
(test (parse '(A v False)) (bor (id 'A)(bool #f)))
(test (parse '(C ^(A v B))) (band (id 'C) (bor (id 'A) (id 'B))))
(test (parse '(with (A True) (A ^ A))) (with 'A (bool #t) (band (id 'A) (id 'A))))

;; test de empty-env
(test empty-env (mtEnv))

;; tests de extend-env
(test (extend-env 'A (BoolV #t) empty-env) (aEnv 'A (BoolV #t) (mtEnv)))
(test (extend-env 'B (BoolV #f) (aEnv 'A (BoolV #t) (mtEnv))) (aEnv 'B (BoolV #f) (aEnv 'A (BoolV #t) (mtEnv))))

;; tests de env-lookup
(test (env-lookup 'A (extend-env 'A (BoolV #f) empty-env)) (BoolV #f))
(test (env-lookup 'A (extend-env 'B (BoolV #f) (aEnv 'A (BoolV #t) (mtEnv)))) (BoolV #t))
(test/exn (env-lookup 'A empty-env) "Identificador A no definido")
(test/exn (env-lookup 'B  (extend-env 'A (BoolV #f) empty-env)) "Identificador B no definido")

;; tests de vand
(test (vand (BoolV #f) (BoolV #f)) (BoolV #f))
(test (vand (BoolV #t) (BoolV #f)) (BoolV #f))
(test (vand (BoolV #f) (BoolV #t)) (BoolV #f))
(test (vand (BoolV #t) (BoolV #t)) (BoolV #t))

;; tests de vor
(test (vor (BoolV #f) (BoolV #f)) (BoolV #f))
(test (vor (BoolV #t) (BoolV #f)) (BoolV #t))
(test (vor (BoolV #f) (BoolV #t)) (BoolV #t))
(test (vor (BoolV #t) (BoolV #t)) (BoolV #t))

;; tests de interp
(test (interp (parse 'True) empty-env) (BoolV #t))
(test/exn (interp (parse '(A ^ False)) empty-env) "Identificador A no definido")
(test/exn (interp (parse '(C ^ (A v B))) empty-env) "Identificador B no definido")
(test (interp (parse '(with (A True)(A ^ False))) empty-env) (BoolV #f))