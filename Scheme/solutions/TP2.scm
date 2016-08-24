#lang racket
(define mylist '(1 2 -3 4 5 -6 7 8 -9))




(define (sum-func f a b)
  (if (> a b)
      0
      (+ (f a) (sum-func f (+ a 1) b))))

(define (cube x) (* x x x))
(define (sum-cubes a b)
  (sum-func cube a b))



(define (how-many n l)
  (count (lambda (x) (equal? n x)) l))

(define (square x) (* x x))
(define (middle f)
  (lambda (x y) (/ (+ (f x) (f y)) 2)))


