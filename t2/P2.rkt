;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;                 P2 - TAREA 2                  ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; NOMBRE APELLIDO: Antonia Labarca
;; Mucho Exito :)

#lang play

#| <logic> ::= 
    | (bool <bool>)
    | (id <id>)
    | (band <logic> <logic>)
    | (bor <logic> <logic>)
    | (with <id> <logic> <logic>)
|#

#| ================================
                PARTE A
   ================================|#
;; tipo de datos inductivo para representar una expresion logica. la gramatica que lo genera esta arriba
(deftype Logic
  (bool b)
  (id i)
  (band p q)
  (bor p q)
  (with i p q)
  )


#| ================================
                PARTE B
   ================================ |#

#| <s-expr> ::= <bool>
             | <sym>
             | (list <s-expr> '^ <s-expr>)
             | (list <s-expr> 'v <s-expr>)
             | (list 'with (list <sym> <s-expr>) <s-expr>)
|#

;; parse :: s-expr -> logic
;; recibe una expresion en sintaxis concreta y la transforma a la sintaxis abstracta, como un objeto tipo Logic
(define (parse s-expr)
  (match s-expr
    [b #:when (equal? 'True b) (bool #t)]
    [c #:when (equal? 'False c) (bool #f)]
    [s #:when (symbol? s) (id s)]
    [(list p '^ q) (band (parse p) (parse q))]
    [(list p 'v q) (bor (parse p) (parse q))]
    [(list 'with (list i p) q) #:when (symbol? i) (with i (parse p) (parse q))]
    )
  )

#| ================================
                PARTE C 
   ================================ |#
#| <lvalue> ::=
    | (BoolV v)
|#
(deftype LValue
  (BoolV v)
  )


#| ================================
                PARTE D
   ================================ |#


;; Interfaz del tipo de dato abstracto que
;; representa los ambientes de identificadores.
;; empty-env  :: Env
;; extend-env :: Sym LValue Env -> Env
;; env-lookup :: Sym Env -> LValue

;; interp :: Logic Env -> LValue

#|   -----------------------------
Environment abstract data type

empty-env :: Env

extend-env :: Sym LValue Env -> Env
env-lookup :: Sym Env -> LValue

representation BNF:
<env> ::= (mtEnv)
       | (aEnv <id> <LValue> <env>)
|#

(deftype Env
  (mtEnv)
  (aEnv id val env)
  )

;; empty-env :: Env
;; un env vacío
(define empty-env (mtEnv))

;; extend-env :: Sym LValue Env -> Env
;; agrega el simbolo y el valor a un nuevo env
(define (extend-env symb val env)
  (aEnv symb val env)
  )

;; env-lookup Sym Env -> LValue
;; busca en un env el valor asociado a un simbolo
(define (env-lookup sym env)
  (match env
    [(mtEnv) (error 'env-lookup "Identificador ~a no definido" sym)]
    [(aEnv id val env) (if (equal? id sym)
                           val
                           (env-lookup sym env))]
    )
  )

;; vand LValue LValue -> LValue
;; un Y logico para LValues
(define (vand v u)
  (if (and (equal? (BoolV #t) v) (equal? (BoolV #t) u))
      (BoolV #t)
      (BoolV #f)
      )
  )

;; vor LValue LValue -> LValue
;; un O logico para LValues
(define (vor v u)
  (if (or (equal? (BoolV #t) v) (equal? (BoolV #t) u))
      (BoolV #t)
      (BoolV #f)
      )
  )

;; interp Logic Env -> LValue
;; interpreta una prop. logica y retorna su valor
(define (interp logic env)
  (match logic
    [(bool b) (BoolV b)]
    [(id i) (env-lookup i env)]
    [(band p q) (vand (interp q env)(interp p env))]
    [(bor p q) (vor (interp q env) (interp p env))]
    [(with i p q) (def new-env (extend-env i (interp p env) env))
                  (interp q new-env)]
    )    
  )

  