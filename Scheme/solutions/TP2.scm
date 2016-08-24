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


; sum-cubes with map
(define (sum-cubes2 a b)
  (apply + (map cube (range a (+ b 1)))))


(define listoflists '((1 2 3 1) (45 1  3 4 5) (4 5 64) 
		(4 6) (144) (0 4 4) (14 464 4 7 6) (1 1 4 65)))
(define (max-list l) (map (lambda (x) (apply max x)) l))

  
(define (mean f)
  (lambda (x y) (/ (+ (f x) (f y)) 2)))

(define mean-cube (mean cube))