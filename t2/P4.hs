{-
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;                 P4 - TAREA 2                  ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; NOMBRE APELLIDO: Antonia Labarca
-}

elem_stirling :: Integer -> Integer -> Integer
elem_stirling m k
  |m==0 && k==0 = 1
  |k==0 = 0
  |m==0 = 0
  |otherwise = elem_stirling (m-1) (k-1) + k * elem_stirling (m-1) k
  
lista_stirling :: Integer -> Integer-> [Integer]
lista_stirling m i
  |i==m = elem_stirling m i :[]
  |otherwise = elem_stirling m i : lista_stirling m (i+1)
  
lista_stirling_2 :: Integer -> [Integer]
lista_stirling_2 m = lista_stirling m 0

ones :: [Integer]
ones = 1:ones

ints :: [Integer]
ints = 0: zipWith (+) ones ints

triangulo_stirling :: [[Integer]]
triangulo_stirling = map lista_stirling_2 ints



main = print $ take 5 triangulo_stirling