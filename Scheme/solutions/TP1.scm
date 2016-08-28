#lang r5rs

; Basics
(define a -8)

(define b
  (if (positive? a)
      (* 2 (sqrt a))
      (/ (* 7 (sqrt (- a))) (- a))))

(display b)


; Functions
(define (cube x) (* x x x))

(define (sum-cubes a b)
  (if (> a b)
      0
      (+ (cube a)
         (sum-cubes (+ a 1) b))))

(sum-cubes 4 5)

; Recursion on numbers
(define (my-even? x)
  (zero? (modulo x 2)))
(define (my-odd? x)
  (not (my-even? x)))

(define (collatz? n)
  (begin
    (display n)
    (cond ((equal? 1 n) #t)
      ((even? n) (collatz? (/ n 2)))
      (else (collatz? (+ (* n 3) 1))))))


; Tail recursive
(define (sum-cubes-tail a b)
  (define (sum-cubes-iter a b sum)
    (if (> a b)
        sum
        (sum-cubes-iter (+ a 1) b (+ (cube a) sum))))
  (sum-cubes-iter a b 0))

; Recursion on lists

(define (how-many x l)
  (cond ((null? l) 0)
        ((equal? x (car l)) (+ 1 (how-many x (cdr l))))
        (else (how-many x (cdr l)))))

(define mylist '(1 4 7 3 a 1 3 4 8 9 2 1 a 4 6 a 0 3 4 9))
(how-many 3 mylist)
(how-many 'a mylist)
(how-many '() mylist)


(define (duplicate l)
  (if (null? l) '()
        (append (list (car l) (car l)) (duplicate (cdr l)))))

(define (collatz-list n)
  (cond ((equal? 1 n) '(1))
      ((even? n) (cons n (collatz-list (/ n 2))))
      (else (cons n (collatz-list (+ (* n 3) 1))))))

