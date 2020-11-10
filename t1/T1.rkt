#lang play
(require math/flonum)

#|
Complete sus datos personales:
NOMBRE Y APELLIDO: Antonia Labarca Sanchez
RUT: 20.072.551-4
|#



;; Parte a)

#|
<CFraction> ::= (simple <value>)
              | (compound <value> <value> <CFraction>)

|#
;; Tipo de datos inductivo para representar fracciones compuestas
(deftype CFraction
  (simple a)
  (compound a b d)
 )



;; Parte b)

;; eval :: CFraction -> Rational
;; evalua una fraccion continua, devolviendo el racional que representa
(define (eval cfrac)
  (match cfrac
    [(simple a) a]
    [(compound a b d) (+ a (/ b (eval d)))]
   )
 )



;; Parte c)

;; degree ::  CFraction -> Integer
;; retorna el grado de una fraccion continua
(define (degree cfrac)
  (match cfrac
    [(simple _) 0]
    [(compound _ _ d) (+ 1 (degree d))]
   )
 )



;; Parte d)

;; fold :: (Integer -> A) (Integer Integer A -> A) -> (CFraction -> A)
;; captura el esquema de recursion asociado a CFraction
(define (fold f g)
  (lambda (cf)
    (match cf
      [(simple a) (f a)]
      [(compound a b d) (g a b
                          ((fold f g) d))]
     )
   )
 )



;; Parte e)

;; eval2 :: CFraction -> Rational
;; evalua una fraccion continua, usando la funcion fold definida antes
(define (eval2 cfrac)
  ((fold identity (lambda (x y z) (+ x (/ y z)))) cfrac)
 )


;; degree2 ::  CFraction -> Integer
;; retorna el grado de una fraccion continua, usando la funcion fold definida antes
(define (degree2 cfrac)
  ((fold (lambda (x) 0) (lambda (x y z) (+ 1 z))) cfrac)
 )



;; Parte f)

;; mysterious-cf :: Integer -> CFraction
;; entrega la n-esima fraccion de la serie de fracciones misteriosas del enunciado
;; suponiendo que los numeradores son los impares al cuadrado y que el valor de los denominadores finales es 6 siempre
(define (mysterious-cf n [d 3] [i 0])
  (if (negative? n) (error "Error: argumento negativo :(")
      (if (zero? n) (simple d)
          (compound d (expt (+ (* 2 i) 1) 2) (mysterious-cf (- n 1) 6 (+ 1 i)))
      )
   )
 )



;; Parte g)

;; from-to :: Integer -> Integer -> listOf Integer
;; entrega una lista de numeros enteros entre 2 valores enteros, incluyendo a ambos
(define (from-to ini fin)
  (if (> ini fin) (error "Error: el 1o parametro debe ser menor que el 2o")
     (if (equal? ini fin) (list fin)
         (append (list ini) (from-to (+ 1 ini) fin))
      )
   )
)

;; eval-mysterious :: Integer -> Float
;; entrega la evaluacion y conversion a float de la n-esima fraccion misteriosa
(define (eval-mysterious n)
  (fl (eval (mysterious-cf n)))
)

;; mysterious-list :: Integer -> listOf Float
;; entrega una lista de las primeras n mysterious-cf evaluadas y mostradas como numero float
;; se considera que el 3 es la primera fraccion misteriosa, por lo que se entrega las frac misteriosas entre 0 y n-1
(define (mysterious-list n)
  (if (or (negative? n) (zero? n)) (error "Error: el argumento debe ser mayor a 0 :(")
    (map eval-mysterious (from-to 0 (- n 1)))
   )
 )

;; A que numero tiende (mysterious-cf k) cuando k tiende a infinito?
;; a simple vista, habiendo probado (mysterious-list 20), parece ser que tiende a pi :o



;; Parte h)
;; rac-to-cf :: Rational -> CFraction
(define (rac-to-cf rac)
  (if (integer? rac) (simple rac)
      (compound (floor rac) 1 (rac-to-cf (/ 1 (- rac (floor rac)))))
   )
 )