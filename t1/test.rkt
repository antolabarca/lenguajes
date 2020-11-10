#lang play
(require "T1.rkt")

(print-only-errors #t)

;; tests de eval
(test (eval (simple 0)) 0)
(test (eval (simple 5)) 5)
(test (eval (compound 3 2 (simple 1))) 5)
(test (eval (compound 0 1 (simple 5))) (/ 1 5))
(test (eval (compound 3 1 (compound 4 1 (compound 12 1 (simple 4)))))(+ 3(/ 49 200)))

;; tests de degree
(test (degree (simple 1)) 0)
(test (degree (simple 0)) 0)
(test (degree (compound 3 2 (simple 1))) 1)
(test (degree (compound 1 2 (compound 1 1  (simple 1)))) 2)

;; tests de fold
(test ((fold identity max) (simple 1)) 1)
(test ((fold identity max) (compound 3 1 (simple 4))) 4)
(test ((fold identity +) (simple 1)) 1)
(test ((fold identity +) (compound 1 2 (simple 3))) 6)

;; tests de eval2
(test (eval2 (simple 0)) 0)
(test (eval2 (simple 5)) 5)
(test (eval2 (compound 3 2 (simple 1))) 5)
(test (eval2 (compound 0 1 (simple 5))) (/ 1 5))
(test (eval2 (compound 3 1 (compound 4 1 (compound 12 1 (simple 4)))))(+ 3(/ 49 200)))

;; tests de degree2
(test (degree2 (simple 1)) 0)
(test (degree2 (simple 0)) 0)
(test (degree2 (compound 3 2 (simple 1))) 1)
(test (degree2 (compound 1 2 (compound 1 1  (simple 1)))) 2)

;; tests mysterious-cf
(test (mysterious-cf 0) (simple 3))
(test (mysterious-cf 1) (compound 3 1 (simple 6)))
(test (mysterious-cf 2) (compound 3 1 (compound 6 9 (simple 6))))
(test (mysterious-cf 3) (compound 3 1 (compound 6 9 (compound 6 25 (simple 6)))))

;; tests de from-to
(test (from-to 2 2) '(2))
(test (from-to 0 3) '(0 1 2 3))
(test (from-to 5 6) '(5 6))

;; tests de eval-mysterious
(test (eval-mysterious 0) 3.0)
(test (eval-mysterious 1) 3.1666666666666665)
(test (eval-mysterious 2) 3.1333333333333333)
(test (eval-mysterious 3) 3.145238095238095)

;; tests de mysterious-list
(test (mysterious-list 1) '(3.0))
(test (mysterious-list 2) '(3.0 3.1666666666666665))
(test (mysterious-list 3) '(3.0 3.1666666666666665 3.1333333333333333))
(test (mysterious-list 4) '(3.0 3.1666666666666665 3.1333333333333333 3.145238095238095))

;; tests de rac-to-cf
(test (rac-to-cf 4) (simple 4))
(test (rac-to-cf 3/2) (compound 1 1 (simple 2)))
(test (rac-to-cf (+ 3 49/200)) (compound 3 1 (compound 4 1 (compound 12 1 (simple 4)))))