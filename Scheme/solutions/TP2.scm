#lang r5rs
(define mylist '(1 2 -3 4 5 -6 7 8 -9))


(define (filter p l)
  (cond ((null? l) '())
        ((p (car l))
         (cons (car l) (filter p (cdr l))))
        (else (filter p (cdr l)))))



(define (sum-func f a b)
  (if (> a b)
      0
      (+ (f a) (sum-func f (+ a 1) b))))

(define (cube x) (* x x x))
(define (sum-cubes a b)
  (sum-func cube a b))

(define (range a b)
  (if (> a b)
      '()
      (cons a (range (+ 1 a) b))))

; sum-cubes with map
(define (sum-cubes2 a b)
  (apply + (map cube (range a (+ b 1)))))


(define listoflists '((1 2 3 1) (45 1  3 4 5) (4 5 64)
		(4 6) (144) (0 4 4) (14 464 4 7 6) (1 1 4 65)))
(define (max-list l)
  (map (lambda (x) (apply max x)) l))


(define (mean f)
  (lambda (x y) (/ (+ (f x) (f y)) 2)))

(define mean-cube (mean cube))


; Incorrect my-if implementation
(define (my-if test true false)
  (cond (test true)
         (else false)))
(define x -4)

; my-if with hygienic macros
(define-syntax macro-if
  (syntax-rules ()
    ((macro-if condition exp1 exp2)
     (if condition
         exp1
         exp2))))

; Accumulate
; Switch init and (car args) to define foldr
(define (accumulate init acc args)
  (if (null? args)
      init
      (accumulate (acc (car args) init)
                  acc
                  (cdr args))))
